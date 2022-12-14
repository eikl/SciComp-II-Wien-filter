import matplotlib.pyplot as plt
import numpy as np
from mpl_toolkits.mplot3d import Axes3D
from mpl_toolkits.mplot3d.art3d import Poly3DCollection
import matplotlib.pyplot as plt
import os
from pathlib import Path
import glob
import shutil

#delete old data
old_files = os.listdir()
for file in old_files:
   if ".xyz" in file:
       os.remove(file)



path = Path(os.path.dirname(os.path.realpath(__file__)))
fortran_path = path.parent.absolute()
source_files = str(fortran_path)+"/*.xyz"
target_folder = path

filelist=glob.glob(source_files)
for single_file in filelist:
     # move file with full paths as shutil.move() parameters
    shutil.move(single_file,target_folder) 

fig=plt.figure()
ax = fig.gca(projection="3d")
files = os.listdir()
# for name in files:
#     if ".xyz" not in name:
#         files.remove(name)
files.remove("plotter.py")
ax.set_xlabel('X axis')
ax.set_ylabel('Z axis')
ax.set_zlabel('Y axis')
box=[]
for name in files:
    x = np.loadtxt(name,usecols=0)
    y = np.loadtxt(name,usecols=1)
    z = np.loadtxt(name,usecols=2)
    box.append(x[0])
    box.append(y[0])
    box.append(z[0])
    x=np.delete(x,0)
    y=np.delete(y,0)
    z=np.delete(z,0)
    ax.plot(x,z,y,label=name)
#print(box)
#make the box
points = np.array([[0, -box[1], -box[2]],
                  [box[0],-box[1],-box[2]],
                  [box[0],-box[1],box[2]],
                  [0,-box[1],box[2]],
                  [0,box[1],-box[2]],
                  [box[0],box[1],-box[2]],
                  [box[0],box[1],box[2]],
                  [0,box[1],box[2]]])
#make a 1cm box for particles to get through
# points2 = np.array([[box[0],-0.001,-0.001],
#                    [box[0],-0.001,0.001],
#                    [box[0],0.001,0.001],
#                    [box[0],0.001,-0.001]])

# Z2=points2
# ax.scatter3D(Z2[:, 0],Z2[:, 1],Z2[:, 2])
# verts2  = [[Z2[0],Z2[1],Z2[2],Z2[3]]]
# ax.add_collection3d(Poly3DCollection(verts2, facecolors='red', linewidths=1, edgecolors='r', alpha=.20))

Z = points
ax.scatter3D(Z[:, 0], Z[:, 1], Z[:, 2])
verts = [[Z[0],Z[1],Z[2],Z[3]],
 [Z[4],Z[5],Z[6],Z[7]],
 [Z[0],Z[1],Z[5],Z[4]],
 [Z[2],Z[3],Z[7],Z[6]],
 [Z[1],Z[2],Z[6],Z[5]],
 [Z[4],Z[7],Z[3],Z[0]]]
ax.add_collection3d(Poly3DCollection(verts, facecolors='grey', linewidths=0.5, edgecolors='black', alpha=.20))
plt.legend()
plt.show()