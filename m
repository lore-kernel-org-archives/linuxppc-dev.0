Message-ID: <17B78BDF120BD411B70100500422FC63079F60@IIS000>
From: Patrick Lerda <Lerda@microprocess.com>
To: "'Rolf Liu'" <rolfl@sc.mcel.mot.com>, linuxppc-dev@lists.linuxppc.org
Subject: RE: problems with compiling glibc
Date: Wed, 26 Apr 2000 09:40:09 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Your binutils version is probably too old, check FAQ with glibc, and
gcc-2.95.2,
they give some minimum requirements.

Patrick LERDA

> -----Message d'origine-----
> De:	Rolf Liu [SMTP:rolfl@sc.mcel.mot.com]
> Date:	samedi 29 avril 2000 10:21
> À:	linuxppc-dev@lists.linuxppc.org
> Objet:	problems with compiling glibc
>
>
> Hi,all,
> I have a problem with  compiling the glibc-2.1.3 with gcc(my own
> cross-compiler for
> power pc).the status is :
>
> powerpc-linux-gcc -nostdlib -nostartfiles -r -o crt1.o start.o abi-note.o
> init.o
> /home/lhx/powerpc-linux/bin/ld: unrecognised emulation mode: elf32ppclinux
> Supported emulations: elf32ppc
> collect2: ld returned 1 exit status
> make[1]: *** [crt1.o] Error 1
>
>
> I wonder if elf32ppclinux is  different from elf32ppc ?
> why I got such an error message ?
> thanks a lot .
>
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
