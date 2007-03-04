Return-Path: <mamsadegh@hotmail.com>
Received: from bay0-omc2-s3.bay0.hotmail.com (bay0-omc2-s3.bay0.hotmail.com
	[65.54.246.139]) by ozlabs.org (Postfix) with ESMTP id 67762DDF17
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  5 Mar 2007 10:40:52 +1100 (EST)
Message-ID: <BAY115-W4270CF08F77CA41348714B2850@phx.gbl>
From: Mohammad Sadegh Sadri <mamsadegh@hotmail.com>
To: Linux PPC Linux PPC <linuxppc-embedded@ozlabs.org>
Subject: Xilinx , Ml403, Linux And Money!
Date: Sun, 4 Mar 2007 23:40:51 +0000
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi all,

Money seems to be really important, even when your product is still in beta=
 releases ....

At least, my recent experince with the latest release of EDK and more than =
two weeks of trying different approaches to compile the kernel for ml403 is=
 telling me that ...=20

At the begining stages of my work, some one here told me , "simply use edk =
8.2.02 to generate the linux bsp and then copy the entire files to kernel t=
ree and you are there " ... working and working and working ... I came to t=
his solution at last : ( again another sentence from some one else here ) "=
 I did not use edk generated files for compiling the kernel, .... I just us=
ed xparameters.h and then used the paulus patch " Very interestingly, I'm s=
eeing that the paulus patch is not applied on the main kernel tree , I don'=
t really understand why?=20

Another interesting point is that the GIT development tree of montavista fo=
r ML403 is 9 months old ....

Finally, you see some new app notes from xilinx xapp969 that tells you that=
 you should be able to compile the kernel with exactly no problem and very =
easily if you have purchased either one of montavista or wind river dev kit=
s.... So, Is the version of kernel used in these kits different than what m=
ontavista provides as it's git tree? It should be different because I'm sur=
e that copying EDK files into the git tree provided by them just results so=
me errors.
=20
Finally we see montavista asking for your registration before allowing you =
to download the preview kit, and then their answer "you are not allowed to =
access the prev kit because .... ..... "=20

I was expecting linux kernel source to be free .... But it seems that it is=
 not free at all.
_________________________________________________________________
Explore the seven wonders of the world
http://search.msn.com/results.aspx?q=3D7+wonders+world&mkt=3Den-US&form=3DQ=
BRE=
