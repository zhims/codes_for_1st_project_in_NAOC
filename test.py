import argparse
import os
import numpy as np
import math
import itertools
import time
import datetime
import sys

import torchvision.transforms as transforms
from torchvision.utils import save_image

from torch.utils.data import DataLoader
from torchvision import datasets
from torch.autograd import Variable

from models import *
from datasets import *

import torch.nn as nn
import torch.nn.functional as F
import torch
from PIL import Image

parser = argparse.ArgumentParser()
#parser.add_argument('--epoch', type=int, default=25, help='epoch to start training from')
parser.add_argument('--dataset_name', type=str, default="ours_500", help='name of the dataset')
parser.add_argument('--batch_size', type=int, default=1, help='size of the batches')
parser.add_argument('--img_height', type=int, default=256, help='size of image height')
parser.add_argument('--img_width', type=int, default=256, help='size of image width')
parser.add_argument('--channels', type=int, default=1, help='number of image channels')
#parser.add_argument('--checkpoint_interval', type=int, default=-1, help='interval between model checkpoints')
opt = parser.parse_args()
print(opt)

transforms_ = [ transforms.Resize((opt.img_height, opt.img_width), Image.BICUBIC),
                transforms.ToTensor(),
                transforms.Normalize([0.5], [0.5]) ]

transform_image = transforms.Compose(transforms_)
patch = (1, opt.img_height//2**4, opt.img_width//2**4)
generator = GeneratorUNet()

def get_test_img(file,transform_image):
	img = Image.open('/home/huangx/disk4T/zhangy/G2/GAN2/data/ours_500/test/' + file)
	w, h = img.size
	img_A = img.crop((0, 0, w/2, h))
	#img_A = img_A.convert('RGB')
	img_B = img.crop((w/2, 0, w, h))
	#img_B = img_B.convert('RGB')
	img_A = transform_image(img_A)
	img_B = transform_image(img_B)

	img_A = img_A.view(-1, 1, 256, 256)
	img_B = img_B.view(-1, 1, 256, 256)

	return {'img_A': img_A, 'img_B': img_B}

for opt.epoch in range(0, 199, 3):
	os.chdir('/home/huangx/disk4T/zhangy/G2/GAN2/implementations/pix2pix/')
	generator.load_state_dict(torch.load('saved_models/ours_500/generator_%d.pth' % opt.epoch))
	os.chdir('/home/huangx/disk4T/zhangy/G2/GAN2/data/ours_500/test')
	files = glob.glob('*.png')
	for file in files:
		print(file)
		imgs = get_test_img(file, transform_image)
		real_A = Variable(imgs['img_B'])
		real_B = Variable(imgs['img_A'])
		fake_B = generator(real_A)
		img_sample = torch.cat((real_B.data, fake_B.data), -1)
		os.chdir('/home/huangx/disk4T/zhangy/G2/GAN2/implementations/pix2pix/')
		os.makedirs('test/ours_500/%s' % opt.epoch, exist_ok=True)
		save_image(img_sample, 'test/ours_500/%d/%s' % (opt.epoch, file), normalize=True)
		print('%s is tested' % file)
