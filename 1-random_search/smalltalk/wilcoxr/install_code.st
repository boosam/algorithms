|repo|

repo := MCFileTreeRepository new directory: (FileLocator root / 'home/src' ).

Gofer it repository: repo ; package: 'RandomSearch'; load.

Smalltalk snapshot: true andQuit: true.