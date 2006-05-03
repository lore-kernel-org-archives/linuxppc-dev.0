Return-Path: <simon.v.smith@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.234])
	by ozlabs.org (Postfix) with ESMTP id 0E25867B28
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 May 2006 04:52:40 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 58so204171wri
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 03 May 2006 11:52:39 -0700 (PDT)
Message-ID: <c4b82dc40605031145h18145dcci520a8ee7ff4a7c8@mail.gmail.com>
Date: Wed, 3 May 2006 13:45:19 -0500
From: "Simon Smith" <simon.v.smith@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Sandpoint X3B and 7447 - boot problems
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_1149_13031985.1146681919785"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_1149_13031985.1146681919785
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I'm a new member on this list.  I've been trying to get my Sandpoint
X3B/mpmc7447 to boot a stock Linux kernel from kernel.org (tried 2.6.14 and
2.6.16). I'm running into a boot issue, I load zImage.elf (using DINK32
v13.1.1) -  I get the "Linux/PPC load:" prompt  and then nothing (no more
text, and no more serial port response).

I been searching through the archives - I did come across one email that
mentioned that Motorola(Freescale) started to ship Sandpoint X3B's with
serial #'s > 6000 with "different" switch settings (my board has a serial #
greater than 6000).  I haven't changed any switch settings from the
defaults, the comments in arch/ppc/platforms/sandpoint.c seem to make
reference to switch settings for the X1/2 board - but nothing about the X3B=
.
In all my searching I have yet to find any reference to what the switch
settings for the X3B rev should be for Linux.

If anyone has any pointers regarding the switch settings for the X3B - or
anything else that might help - I would appreciate any help I can get.

Here's my environment:

Development Environment:
-------------------------------------
RedHat Enterprise Linux 4.0
ELDK 4.0 cross devlopment tools

(I'm successufully building zImage for sandpoint_defconfig and cross
compiling for ppc_74xx-)

build steps:
  export CROSS_COMPILE=3Dppc_74xx-
  make ARCH=3Dppc CROSS_COMPILE=3Dppc_74xx- sandpoint_defconfig
  make ARCH=3Dppc CROSS_COMPILE=3Dppc_74xx- zImage

Board:
---------
Sandpoint X3B , serial # > 6000
DINK32 v13.1.1
Altimus (MPMC7447) v1.1
Memory: Map B (CHRP) 128MB at CL3

Thanks,

-Simon.

------=_Part_1149_13031985.1146681919785
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,<br><br>I'm a new member on this list.&nbsp; I've been trying to get my =
Sandpoint X3B/mpmc7447 to boot a stock Linux kernel from <a href=3D"http://=
kernel.org">kernel.org</a> (tried 2.6.14 and 2.6.16). I'm running into a bo=
ot issue, I load=20
zImage.elf (using DINK32 v13.1.1) -&nbsp; I get the &quot;Linux/PPC load:&q=
uot; prompt&nbsp; and then nothing (no more text, and no more serial port r=
esponse).<br><br>I been searching through the archives - I did come across =
one email that mentioned that Motorola(Freescale) started to ship Sandpoint=
 X3B's with serial #'s &gt; 6000 with &quot;different&quot; switch settings=
 (my board has a serial # greater than 6000).&nbsp; I haven't changed any s=
witch settings from the defaults, the comments in arch/ppc/platforms/sandpo=
int.c seem to make reference to switch settings for the X1/2 board - but no=
thing about the X3B. In all my searching I have yet to find any reference t=
o what the switch settings for the X3B rev should be for Linux.
<br><br>If anyone has any pointers regarding the switch settings for the X3=
B - or anything else that might help - I would appreciate any help I can ge=
t.<br><br>Here's my environment:<br><br>Development Environment:<br>-------=
------------------------------
<br>RedHat Enterprise Linux 4.0<br>ELDK 4.0 cross devlopment tools<br><br>(=
I'm successufully building zImage for sandpoint_defconfig and cross compili=
ng for ppc_74xx-)<br><br>build steps:<br>&nbsp; export CROSS_COMPILE=3Dppc_=
74xx-
<br>&nbsp; make ARCH=3Dppc CROSS_COMPILE=3Dppc_74xx- sandpoint_defconfig<br=
>&nbsp; make ARCH=3Dppc CROSS_COMPILE=3Dppc_74xx- zImage<br><br>Board:<br>-=
--------<br>Sandpoint X3B , serial # &gt; 6000<br>DINK32 v13.1.1<br>Altimus=
 (MPMC7447) v1.1
<br>Memory: Map B (CHRP) 128MB at CL3<br><br>Thanks,<br><br>-Simon.<br><br>=
<br>

------=_Part_1149_13031985.1146681919785--
