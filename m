Return-Path: <christophe.alayrac@cresitt.com>
Received: from smtp8-g19.free.fr (smtp8-g19.free.fr [212.27.42.65])
	by ozlabs.org (Postfix) with ESMTP id 6A47ADDDF7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Jan 2007 01:25:10 +1100 (EST)
From: "alayrac" <christophe.alayrac@cresitt.com>
To: "'patel nirav'" <indianirav@yahoo.com>,
	"'linux ppc'" <linuxppc-embedded@ozlabs.org>
Subject: RE : how to cross compile 2.4.18
Date: Thu, 18 Jan 2007 15:25:10 +0100
Message-ID: <001301c73b0c$762b8b40$c900a8c0@CRESITTLAB>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <627126.73541.qm@web30001.mail.mud.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Nirav,

First you can add the path to your brown new cross compiler in your PATH
(export PATH=3D$PATH:/opt/crosstool/...).=20
    To add it permanently to your PATH just add this export line at the
end of your /home/YOURACCOUNT/.bashrc file, it will be take in account
on next open of a shell.

Then to compile the kernel you can do
   make ARCH=3Dppc menuconfig=20
   make ARCH=3Dppc CROSS_COMPILE=3Dpowerxxx- dep zImage
       with powerxxx- the prefix of your cross compiler (in my case it
is powerpc-405-linux-gnu- dont forget the last =96 of the prefix)
or=20
   you can modify the Makefile in the roort directory of your kernel
source and change ARCH and CROSS_COMPILE and then just type
   make menuconfig
   make dep zImage

NOTE : I=92m not sure if ARCH is ppc or powerpc in your case.

Regards

Chris

-----Message d'origine-----
De=A0: =
linuxppc-embedded-bounces+christophe.alayrac=3Dcresitt.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+christophe.alayrac=3Dcresitt.com@ozlabs=
.
org] De la part de patel nirav
Envoy=E9=A0: jeudi 18 janvier 2007 14:30
=C0=A0: linux ppc
Objet=A0: how to cross compile 2.4.18

Hello friends=20
I have installed crosstool-0.42 for the powerpc 604 in the
/opt/crosstool.
Now At the time of Installation I use gcc-3.4.1, glibc-2.3.3 and linux
kernel 2.4.18,
Now my question is how to use the crosstool to cross compile the linux
kernel 2.4.18 for power pc.
