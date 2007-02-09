Return-Path: <tmorrison@empirix.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: device tree / how to build/compile & use with u-boot to boot uImage?
Date: Fri, 9 Feb 2007 16:55:22 -0500
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D901066B2252@EMPBEDEX.empirix.com>
From: "Morrison, Tom" <tmorrison@empirix.com>
To: <linuxppc-embedded@ozlabs.org>,
	<linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

All,

Sorry for my ignorance here, but we have upgraded our kernel from
2.6.11.xx to 2.6.20-rcx (using a specific git-branch for the mpc85xx)=20
to run on the MPC8548CDS eval board (using default options provided=20
by this branch for this eval board). I successfully compiled/loaded the=20
uImage, but it hangs after decompression (with root=3D/dev/nfs)

Also, I was told to upgrade our u-boot source code (with another git=20
branch for to the mpc85xx) and successfully get to the u-boot prompt.

>From googling through the lists - it seems that I need to build a=20
device tree blob and pass that device tree to the kernel in some
fashion?=20

I tried to compile the default dts image (using the dtc compiler=20
installed by LTIB), but it is complaining about no '/chosen' in=20
the definition:

  <path>/dtc -I dts -O dtb - -o mpc8548cds.dtb -V 16 dts/mpc8548cds.dts

I've looked at the Documentation/powerpc/booting_without_of.txt,=20
and this gives an explanation of the internal parts of the dts file,=20
but it doesn't tell me how to practically pass it to the kernel=20
from u-boot (e.g.: load to memory - and use bootm xxx yyy zzz)
=20
I am pretty darn confused about this whole thing. Can anybody point me
to=20
a SUCCINCT explanation of the use of a dts file (and how compile and use

with u-boot to pass to kernel)?

Tom Morrison
Principal Software Engineer


EMPIRIX=20
20 Crosby Drive - Bedford, MA  01730
p: 781.266.3567 f: 781.266.3670=20
email: tmorrison@empirix.com=20
www.empirix.com
