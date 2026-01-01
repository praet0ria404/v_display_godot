# V Display Godot
![alt text](docs/docs_title.png)

## 2D Sprite VTubing Engine
V Display Godot is a Linux exclusive VTubing engine solving problems that nobody ever had. 
It uses ![Open See Face](https://github.com/emilianavt/OpenSeeFace) by emilianavt a library based on MobileNetV3, for realtime face tracking. 
The program provides you a graphical user interface with which you can change the settings of Open See Face and display the 
tracked data of Open See Face. At the time of writing the software I wasn't aware of ![vpupper](https://github.com/virtual-puppet-project/vpupper) another Vtubing Engine written in Godot using OpenSeeFace as a base. Compatibility is currently not very good as the programm only works on Linux.

## Dependencies
- Python 3.6-3.9
- Onnx Runtime
- OpenCV
- Pillow
- Numpy <br>
<!-- End of List -->

The libraries are required or OpenSeeFace will not start tracking.
They can be install with the following command, inside of your pip3 envoirnment.
```
pip3 install onnxruntime opencv-python pillow numpy
```

## Model Sprites
Per default the projects comes with only a model: 
- A crt cat that is saved in [mascot_model.gd](/model/mascot)


## Making Your Own Model
The only thing you need to do to make your own model is importing your sprites keeping the scene structure. Currently you need to either run VDisplay Godot 
in engine or recompile before you can actually use it
This will be fixed in a future update, when I find the time.
I am also going to implement a loader for Live2D model in the future.


## Video Tutorial 
In the near future I am going to upload a "short" video on Youtube explaining 
the base concept of a CNN and my visualization engine.


## Licences
The code and my model are distributed / licensed under the BSD2-clause licence.
Because the project uses OpenSeeFace it's licences are also provided in the ![LICENCES](/LICENCES) folder
