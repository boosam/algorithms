FROM geal/archlinux-pharo-smalltalk 

ADD . /home/

RUN ./pharo Pharo.image ./install_code.st 
CMD ["./pharo", "Pharo.image", "./sampler.st"]