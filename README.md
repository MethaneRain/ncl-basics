# ncl-basics
Basics of NCAR's Command Language (NCL)
---

Even though NCAR is transitioning towards Pyhton, they stated they wont be abandoning NCL so I though I'd expand my atmospheric science software toolkit by learning the basics of NCL.

---

The first major hurdle I ran into was installing NCL via Conda from NCAR's website: [http://www.ncl.ucar.edu/Download/conda.shtml](http://www.ncl.ucar.edu/Download/conda.shtml "NCL Conda Install")

The Conda environment was created no problem, but when checking if NCL was installed coreectly, I ran into an error:
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

Printing ```ncl -V``` in the activated environment resulted in ```6.5.0```
