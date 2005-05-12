Return-Path: <mcnernbm@notes.udayton.edu>
Received: from student03.udayton.edu (student03.udayton.edu [131.238.75.43])
	by ozlabs.org (Postfix) with ESMTP id EE95467A33
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 May 2005 08:30:24 +1000 (EST)
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Message-ID: <OF00AFA172.E54B585D-ON85256FFF.007A6F97-85256FFF.007BA138@notes.udayton.edu>
From: mcnernbm@notes.udayton.edu
Date: Thu, 12 May 2005 18:30:17 -0400
Content-Type: multipart/alternative;
	boundary="=_alternative 007BA12485256FFF_="
Subject: Kernel build error
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 007BA12485256FFF_=
Content-Type: text/plain; charset="US-ASCII"

Using the 2.4 kernel tree with a 2.4.26 kernel I am receive the following 
error when trying to build for the powerpc 405.
I set the arch: to arch: ppc and set the cross-compile line in the make 
file. 
Make dep and make modules runs fine.
But when I run make zImage I receive the follwoing error:

mv: can't stat source zvmlinux
make[2]: *** [zImage] Error 1
make[2]: Leaving directory 
'/ppclinux/v2.4.26_linuxppc_2_4_devel/linuxppc_2_4_devel/arch/ppc/boot/simple'
make[1]: *** [zImage] Error 2
make[1]: Leaving directory 
'/ppclinux/v2.4.26_linuxppc_2_4_devel/linuxppc_2_4_devel/arch/ppc/boot/'
make: *** [zImage] Error 2

I am using the default xilinx_ml300 arch config file so I can at least get 
the kernel to build before attempting to build one for my specific virtex 
II pro board.  Does anyone know what might be causing this?

I am using gcc-3.4.1 and glibc-2.3.5.  Not sure if this is part of the 
issue or but if so which version should I be using?  And is it the 2.4.26 
kernel that is the issue?  Should i go back to an older one that is used 
in alot of the tutorials for the xilinx ml300 board.
Thanks
Brett
--=_alternative 007BA12485256FFF_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Using the 2.4 kernel tree with a 2.4.26
kernel I am receive the following error when trying to build for the powerpc
405.</font>
<br><font size=2 face="sans-serif">I set the arch: to arch: ppc and set
the cross-compile line in the make file. </font>
<br><font size=2 face="sans-serif">Make dep and make modules runs fine.</font>
<br><font size=2 face="sans-serif">But when I run make zImage I receive
the follwoing error:</font>
<br>
<br><font size=2 face="sans-serif">mv: can't stat source zvmlinux</font>
<br><font size=2 face="sans-serif">make[2]: *** [zImage] Error 1</font>
<br><font size=2 face="sans-serif">make[2]: Leaving directory '/ppclinux/v2.4.26_linuxppc_2_4_devel/linuxppc_2_4_devel/arch/ppc/boot/simple'</font>
<br><font size=2 face="sans-serif">make[1]: *** [zImage] Error 2</font>
<br><font size=2 face="sans-serif">make[1]: Leaving directory '/ppclinux/v2.4.26_linuxppc_2_4_devel/linuxppc_2_4_devel/arch/ppc/boot/'</font>
<br><font size=2 face="sans-serif">make: *** [zImage] Error 2</font>
<br>
<br><font size=2 face="sans-serif">I am using the default xilinx_ml300
arch config file so I can at least get the kernel to build before attempting
to build one for my specific virtex II pro board. &nbsp;Does anyone know
what might be causing this?</font>
<br>
<br><font size=2 face="sans-serif">I am using gcc-3.4.1 and glibc-2.3.5.
&nbsp;Not sure if this is part of the issue or but if so which version
should I be using? &nbsp;And is it the 2.4.26 kernel that is the issue?
&nbsp;Should i go back to an older one that is used in alot of the tutorials
for the xilinx ml300 board.</font>
<br><font size=2 face="sans-serif">Thanks</font>
<br><font size=2 face="sans-serif">Brett</font>
--=_alternative 007BA12485256FFF_=--
