# ncl-basics
Basics of NCAR's Command Language (NCL)
---

Even though NCAR is transitioning towards Pyhton, they stated they wont be abandoning NCL so I though I'd expand my atmospheric science software toolkit by learning the basics of NCL.

---

The first major hurdle I ran into was installing NCL via Conda from NCAR's website: [http://www.ncl.ucar.edu/Download/conda.shtml](http://www.ncl.ucar.edu/Download/conda.shtml "NCL Conda Install")

The Conda environment was created no problem, but when checking if NCL was installed correctly, I ran into an error:
```
dyld: Library not loaded: @rpath/libwebp.7.dylib

Referenced from: /Users/chowdahead/anaconda3/envs/test-ncl/lib/libtiff.5.dylib

  Reason: Incompatible library version: libtiff.5.dylib requires version 9.0.0 or later, but libwebp.7.dylib provides version 8.0.0


Abort trap: 6
```

I was not able to overcome this error yet, I am waiting to hear from the support team about how to approach this. In the mean time I was able to get NCL installed with PyNio via Conda:
```
conda create --name ncl_to_python --channel conda-forge/label/cf201901 pynio
```

Notice the extra cf201901 before the pynio argument. Now everything is all good!!

Printing ```ncl -V``` in the activated environment resulted in ```6.5.0```!

---

### Getting to know basic variables

The syntax is simialr to many languages and variables can be assigned
```
var=12.0
```
Just like Python, we can print out the value of the variable:
```
print(var)
>>> 12.0
```
We can reassign the varibale to a new value <strong>as long as the variable type is the same!!</strong>
```
var=6.0
print(var)
>>> 6.0
```
However, if we want to reassign the variable to a string, we will run into an error:
```
var="houseboat"
fatal:["NclVar.c":1390]:Assignment type mismatch, right hand side can't be coerced to type of left hand side
```

---