Return-Path: <troy.laramy@gmail.com>
Received: from mail-fx0-f221.google.com (mail-fx0-f221.google.com
	[209.85.220.221]) by ozlabs.org (Postfix) with ESMTP id 9077AB7CF1
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 27 Mar 2010 06:04:05 +1100 (EST)
Received: by fxm21 with SMTP id 21so883718fxm.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 26 Mar 2010 12:04:02 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 26 Mar 2010 13:04:02 -0600
Message-ID: <f9c38d471003261204g2337bce8ja66a3ca46513dd7e@mail.gmail.com>
Subject: u-boot build errors on LTIB 20100115 for MSP8572DS
From: Troy Laramy <troy.laramy@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=001485f795f499bed10482b8d314
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001485f795f499bed10482b8d314
Content-Type: text/plain; charset=ISO-8859-1

Hi, I am having trouble building u-boot (from u-boot-2009.11-mpc8572ds.spec)
from LTIB for the MPC8572DS platform using just the Makefile and freescale
cross tools.  The build machine is CentOS 5.3.  This is procedure I am
following (on LTIB for MPC8572DS, 20100115):

# cd ltib-mpc8572ds-20100115
# ./ltib -m prep -p u-boot-2009.11-mpc8572ds.spec
# ./ltib -m scbuild -p u-boot-2009.11-mpc8572ds.spec
# cd rpm/BUILD/

2. confirm configuration and make
# cd u-boot-2009.11-rc1-19
# make ARCH=powerpc CROSS_COMPILE=/......../bin/powerpc-none-linux-gnuspe-
MPC8572DS_NAND_config
# make ARCH=powerpc CROSS_COMPILE=/......../bin/powerpc-none-linux-gnuspe-
all

but i'm getting (several) compile errors from the make.  It goes for a
while, then gets errors at different points, depending on how much it has to
build:
Usually, just syntax errors or something like:
make -C lib_powerpc/
make: *** lib_powerpc/: No such file or directory.  Stop.
make: *** [lib_powerpc/libpowerpc.a] Error 2
....however I can still build using ./ltib???
shouldn't I be able to build from make?  (as per the MPC8572DS NAND
bootloader User Manual HTML doc)?    Is there some other way I should be
building?  Any help would be much appreciated!

Thanks very much,
Troy

--001485f795f499bed10482b8d314
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi, I am having trouble building u-boot (from u-boot-2009.11-mpc8572ds=
.spec) from LTIB for the MPC8572DS platform using just the Makefile and fre=
escale cross tools.=A0 The build machine is CentOS 5.3.=A0 This is procedur=
e I am following (on LTIB for MPC8572DS, 20100115):</div>

<div>=A0</div>
<div># cd ltib-mpc8572ds-20100115<br># ./ltib -m prep -p u-boot-2009.11-mpc=
8572ds.spec<br># ./ltib -m scbuild -p u-boot-2009.11-mpc8572ds.spec<br># cd=
 rpm/BUILD/ </div>
<p></p>
<p>2. confirm configuration and make</p>
<div># cd u-boot-2009.11-rc1-19</div>
<div><font size=3D"2" face=3D"tahoma"># make ARCH=3Dpowerpc CROSS_COMPILE=
=3D/......../bin/powerpc-none-linux-gnuspe- MPC8572DS_NAND_config</font><br=
># <font size=3D"2">make ARCH=3Dpowerpc CROSS_COMPILE=3D/......../bin/power=
pc-none-linux-gnuspe- all</font></div>

<div>=A0</div>
<div><font size=3D"2" face=3D"tahoma">but i&#39;m getting (several) compile=
 errors from the make.=A0 It goes for a while, then gets errors at differen=
t points, depending on how much it has to build:</font></div>
<div><font size=3D"2" face=3D"tahoma">Usually, just syntax errors or someth=
ing like:</font></div>
<div><font size=3D"2" face=3D"tahoma">make -C lib_powerpc/<br>make: *** lib=
_powerpc/: No such file or directory.=A0 Stop.<br>make: *** [lib_powerpc/li=
bpowerpc.a] Error 2<br>....however I can still build using ./ltib???</font>=
=A0</div>

<div><font size=3D"2" face=3D"tahoma">shouldn&#39;t I be able to build from=
 make?=A0 (as per the MPC8572DS NAND bootloader User Manual HTML doc)?=A0=
=A0=A0 Is there some other way I should be building?=A0 Any help would be m=
uch appreciated!</font></div>

<div><font face=3D"Tahoma"></font>=A0</div>
<div><font face=3D"Tahoma">Thanks very much,</font></div>
<div><font face=3D"Tahoma">Troy</font></div>

--001485f795f499bed10482b8d314--
