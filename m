Return-Path: <frank.lautenbach@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 1D33067D40
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Jul 2005 02:52:58 +1000 (EST)
Message-ID: <42E51849.7050800@gmx.de>
Date: Mon, 25 Jul 2005 18:50:17 +0200
From: Frank Lautenbach <frank.lautenbach@gmx.de>
MIME-Version: 1.0
To: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Getting a kernel to run on AMCC 440EP (Bamboo)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi folks,

I want to bring up a linux kernel on the AMCC 440EP board (Bamboo). 
(still!  ;-) )

I managed to compile the kernel sources from kernel.org (2.6.12.3) with 
a cross tool chain created with
this great script from kegel.com (using demo-ppc440.sh). I set ARCH=ppc 
and CROSS_COMPILE=powerpc-440-linux-gnu-
during the configuration procedure (using xconfig) as well as for the 
actual buil process. Of course, I also
added the path to the ppc-crosstools to my PATH variable. Seems I did 
all that right, because the build process succeeded.

Finally I got an zImage.elf file (among some other variants) after the 
make process in .../arch/ppc/boot/images which I tried to load
via TFTP of the PIBS ROM Monitor. After the image has been loaded into 
RAM I get
a lapidar "error: can not process ELF program header, status: command 
rc=-1" and that's it...

When I examine the image file with readelf everything seems to be all 
right. All data seems to be plausible
and it is in fact a binary for PPC.

Anyhow seems to be wrong with the header format... Has anyone a guess 
what's the problem? Is PIBS
not able to load kernel images at all? Or do I have to create another 
kind of image format?

By the way:

Do I have to rearrange the default memory mapping of this board to get 
at least some success with the linux kernel?


Thanks for your help and sorry for my lame questioning... I am just new 
to this domain...

Bests,
    Frank
