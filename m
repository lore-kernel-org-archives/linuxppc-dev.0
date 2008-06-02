Return-Path: <schandra@in.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id A638ADDF0C
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  2 Jun 2008 20:52:16 +1000 (EST)
Received: from [10.161.2.93] (unknown [10.161.2.93])
	by imap.sh.mvista.com (Postfix) with ESMTP id C668F3ECA
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  2 Jun 2008 03:35:25 -0700 (PDT)
Subject: ML507 EDK 10.1
From: somshekar c kadam <schandra@in.mvista.com>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Tue, 03 Jun 2008 03:48:48 +0530
Message-Id: <1212445128.3187.20.camel@localhost.localdomain>
Mime-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All,

Currently I am working with ML507 Base Reference design. I  have
installed Eval 10.1 edk I am bale to create ace file using xmd with base
download.bit. and able to boot the board. Now I want to boot the board
with Xilinx Linux kernel from Xilinx git tree. I am facing compilation
problem with zImage.dts for ml507_defconfig.

  


now I need to create ace file for Linux for ML507.
I tried creating zImage.dts its failing. Kernel error see below

Please help or give some pointers wherein I can compile zImge.dts. this
is from latest git tree. Seems for me arch/powerpc wrapper code is
broken. Please suggest.
currently I have no bdi I need to stick to Ace compact Flash booting.
Also bit confused where we have two git tree one is Xilinx git tree one
more from Grant Likely which should I use ?

Thanks In Advance

Neelu

---------------------------------------------------
WRAP    arch/powerpc/boot/zImage.dts
DTC: dts->dtb  on file
"/home/neelu/xilinx/xilinx_gittree/test44/linux-2.6-xlnx/arch/powerpc/boot/dts/ml507.dts"
objcopy: Unable to recognise the format of the input file `vmlinux'
make[1]: *** [arch/powerpc/boot/zImage.dts] Error 1
make: *** [zImage.dts] Error 2




WIth Verbose =1 


 /bin/sh /home/neelu/xilinx/xilinx_gittree/test44/linux-2.6-xlnx/arch/powerpc/boot/wrapper -c -o arch/powerpc/boot/zImage.dts -p dts   -s /home/neelu/xilinx/xilinx_gittree/test44/linux-2.6-xlnx/arch/powerpc/boot/dts/ml507.dts vmlinux
+ kernel=
+ ofile=zImage
+ platform=of
+ initrd=
+ dtb=
+ dts=
+ cacheit=
+ binary=
+ gzip=.gz
+ CROSS=
+ object=arch/powerpc/boot
+ objbin=arch/powerpc/boot
+ tmpdir=.
+ '[' 8 -gt 0 ']'
+ case "$1" in
+ cacheit=y
+ shift
+ '[' 7 -gt 0 ']'
+ case "$1" in
+ shift
+ '[' 6 -gt 0 ']'
+ ofile=arch/powerpc/boot/zImage.dts
+ shift
+ '[' 5 -gt 0 ']'
+ case "$1" in
+ shift
+ '[' 4 -gt 0 ']'
+ platform=dts
+ shift
+ '[' 3 -gt 0 ']'
+ case "$1" in
+ shift
+ '[' 2 -gt 0 ']'
+
dts=/home/neelu/xilinx/xilinx_gittree/test44/linux-2.6-xlnx/arch/powerpc/boot/dts/ml507.dts
+ shift
+ '[' 1 -gt 0 ']'
+ case "$1" in
+ '[' -z '' ']'
+ kernel=vmlinux
+ shift
+ '[' 0 -gt 0 ']'
+ '['
-n /home/neelu/xilinx/xilinx_gittree/test44/linux-2.6-xlnx/arch/powerpc/boot/dts/ml507.dts ']'
+ '[' '!'
-r /home/neelu/xilinx/xilinx_gittree/test44/linux-2.6-xlnx/arch/powerpc/boot/dts/ml507.dts -a -r arch/powerpc/boot/dts//home/neelu/xilinx/xilinx_gittree/test44/linux-2.6-xlnx/arch/powerpc/boot/dts/ml507.dts ']'
+ '[' -z '' ']'
+ dtb=dts.dtb
+ arch/powerpc/boot/dtc -O dtb -o dts.dtb -b
0 /home/neelu/xilinx/xilinx_gittree/test44/linux-2.6-xlnx/arch/powerpc/boot/dts/ml507.dts
DTC: dts->dtb  on file
"/home/neelu/xilinx/xilinx_gittree/test44/linux-2.6-xlnx/arch/powerpc/boot/dts/ml507.dts"
+ '[' -z vmlinux ']'
+ platformo=arch/powerpc/boot/dts.o
+ lds=arch/powerpc/boot/zImage.lds
+ ext=strip
+ objflags=-S
+ tmp=./zImage.24209.o
+ ksection=.kernel:vmlinux.strip
+ isection=.kernel:initrd
+ case "$platform" in
++ basename vmlinux
+ vmz=./vmlinux.strip
+ '[' -z y -o '!' -f ./vmlinux.strip.gz -o ./vmlinux.strip.gz -ot
vmlinux ']'
+ objcopy -S vmlinux ./vmlinux.strip.24209
objcopy: Unable to recognise the format of the input file `vmlinux'
make[1]: *** [arch/powerpc/boot/zImage.dts] Error 1
make: *** [zImage.dts] Error 2





------------------------------------------------------------------------------------------
