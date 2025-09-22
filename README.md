# V Display Godot
![alt text](docs/docs_title.png)

## 2D Sprite VTubing Engine
V Display Godot is a Linux exclusive VTubing Engine solving problems that nobody ever had. 
It uses ![Open See Face](https://github.com/emilianavt/OpenSeeFace) by emilianavt for realtime face tracking. 
The program provides you a graphical user interface with which you can change the settings of Open See Face and display the 
tracked data of Open See Face. At the time of writing the software I wasn't aware of ![vpupper](https://github.com/virtual-puppet-project/vpupper) another Vtubing Engine writting in Godot using OpenSeeFace as a base. Compatibility is currently not very good as the programm only works on Linux.

## Dependencies
- Python 3.6-3.9
- Onnx Runtime
- OpenCV
- Pillow
- Numpy <br>
<!-- End of List -->
The libraries are required or OpenSeeFace will not start tracking.
They can be install with the following command.
```
pip3 install onnxruntime opencv-python pillow numpy
```

## Model Sprites
Per default the projects comes with two models:
- My Personal model: (Praet0ria)
![alt text]()
- My little mascot: (CRT-cat)

## Licences
The code and my models are distributed / licensced under the BSD2-clause licence. 
Because the project uses OpenSeeFace it's licences are also provided in the ![LICENCES](/LICENCES) folder
