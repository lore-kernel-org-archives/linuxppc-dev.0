Date: Fri, 22 Nov 2002 18:26:04 +0800
From: caixupeng <edmoon@huawei.com>
Subject: Re: compile a linux kernel for ppc4xx, error message
To: Aman <aman@mistralsoftware.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Message-id: <000701c29211$90689eb0$33690b0a@DBKQW41X>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
References: <001501c291c2$04745150$33690b0a@DBKQW41X>
 <001001c291ec$be79adf0$370da8c0@aman>
 <000901c291f2$952c3250$33690b0a@DBKQW41X> <009901c291fb$16c84e40$370da8c0@aman>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wonderful!
I  download the newest develeping version of linux kernel from bitkeeper.
And compiled without any errors.

I don't have any Montvista or others. I only have binutils-2.13 and gcc-core-2.95.3.

thank you very much!

        edmoon


----- Original Message -----
From: "Aman" <aman@mistralsoftware.com>
To: "caixupeng" <edmoon@huawei.com>
Sent: Friday, November 22, 2002 3:45 PM
Subject: Re: compile a linux kernel for ppc4xx, error message

> 1. The Linux kernel is available as a tar'd file from the following site:
> http://www.ppckernel.org/tree.php?id=5
> 2. These kernels are in a constant state of change, as developers upload
> revised versions.
> 3. The latest version is titled "BitKeeper  2.4 development".  This actually
> contains  kernels targeted to a number of  processors in addition to the
> 440.
> 4. The tar'd file should be downloaded to a local machine then  untar'd,
> which will in turn yield a set of directories for the  different kernel
> targets.
> 5. Traverse to the 4xx directory, and therein will reside the necessary
> source code.
> 6. In order to compile the software, I believe you will need the MontaVista
> cross compiler. [ Do you have Montavist compiler, if not try "Embedded Linux
> Development Kit" at www.denx.de]
> 7. In order to make the kernel,  If you just want to play with the _devel
> tree then use your
>  ppc_405- toolchain to build the kernel. Edit the top-level Makefile to say
> "ARCH := ppc" and "CROSS_COMPILE := ppc_405-". [ If you don't have
> "ppc_405-" tool set, set the appropriate compiler you hv]
> make ebony_config
> make oldconfig
> make dep
> make clean
> make zImage

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
