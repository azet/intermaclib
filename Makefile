CC=gcc
CFLAGS=-ggdb -Wall -O0 -Wuninitialized -Wsign-compare -Wformat-security -D_FORTIFY_SOURCE=2 -fstack-protector -fPIE
LDFLAGS=-Wl,-z,relro -Wl,-z,now -Wl,-z,noexecstack -fstack-protector-all -pie
LIBS=-lcrypto
OBJS=test.o im_chacha.o im_poly.o im_chacha_poly.o im_aes_gcm.o im_cipher.o im_core.o explicit_bzero.o timingsafe_bcmp.o
DEPS=im_chacha.h im_poly.h im_chacha_poly.h im_aes_gcm.h cipher_includes.h im_cipher.h im_core.h

all: testintermac libintermac.a

%.o : %.c $(DEPS)
	$(CC) $(CFLAGS) -c $< -o $@

testintermac: $(OBJS)
	$(CC) -o $@ $(OBJS) $(LDFLAGS) $(LIBS) 

libintermac.a: $(OBJS)
	ar rv $@ $(OBJS)
	ranlib $@ 

clean: 
	rm *.o
	rm *.a
	testintermac
