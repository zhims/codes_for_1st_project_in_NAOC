import os
import sys
import imageio
from scipy.io import readsav
import numpy as np
path =  sys.path[0]
dirs = os.listdir(path)  
for i in dirs:
	if os.path.splitext(i)[1] == '.sav':
          savData = readsav(os.path.join(path,i))
          x = savData.imag 
          y = os.path.splitext(i)[0] + '.txt'
          y = os.path.join(path,y)
          np.savetxt(y,x)