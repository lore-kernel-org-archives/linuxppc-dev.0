Return-Path: <John.Linn@xilinx.com>
Received: from outbound6-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id ADD1EDE087
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 02:59:38 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Booting a Xilinx board
Date: Mon, 7 Apr 2008 10:59:25 -0600
In-Reply-To: <20080407164421.44D46CC0050@mail102-sin.bigfish.com>
References: <10a101c898c4$c183ee40$f52f9e86@LPSC0173W>
	<20080407164421.44D46CC0050@mail102-sin.bigfish.com>
From: "John Linn" <John.Linn@xilinx.com>
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>,
	"Guillaume Dargaud" <dargaud@lpsc.in2p3.fr>, <linuxppc-dev@ozlabs.org>
Message-Id: <20080407165928.18E4830008F@mail126-dub.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

You can also get our support file from the http git web site and then
use the default ML405 kernel configuration just as a baseline to get the
kernel running.  The support file has a bit stream that supports the 405
def kernel configuration.

Thanks,
John

-----Original Message-----
From: linuxppc-dev-bounces+john.linn=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-dev-bounces+john.linn=3Dxilinx.com@ozlabs.org] On =
Behalf
Of Stephen Neuendorffer
Sent: Monday, April 07, 2008 10:44 AM
To: Guillaume Dargaud; linuxppc-dev@ozlabs.org
Subject: RE: Booting a Xilinx board


Generally, speaking the easiest way to debug such errors is to examine
__log_buf using XMD.

Steve

> -----Original Message-----
> From: =
linuxppc-dev-bounces+stephen.neuendorffer=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-dev-
> bounces+stephen.neuendorffer=3Dxilinx.com@ozlabs.org] On Behalf Of
Guillaume Dargaud
> Sent: Monday, April 07, 2008 8:34 AM
> To: linuxppc-dev@ozlabs.org
> Subject: Booting a Xilinx board
>=20
> Hello all,
> sorry if this is an elementary question for most of you, but could you
tell
> me where I'm going wrong in trying to boot a kernel 2.6.24 on a Xilinx
ml405
> board ?
>=20
> - I generate an ext2 partition with buildroot, cointaining busybox and
> uclibc.
>=20
> - I copy it to my CF card:
> sudo dd if=3Dbinaries/genepy/rootfs.test.ext2 of=3D/dev/sdc2
>=20
> - I compile the git Xilinx kernel, with proper xparameters file from
the BSP
> and proper .config options to match the design, using the cross
compiler
> created by buildroot.
>=20
> - I generate a sysace file from that kernel and put it on the 1st
partition:
> xmd -tcl genace.tcl -jprog -board ml405 -target ppc_hw -hw
> implementation/system.bit -elf
> ~/kernels/linux-2.6.24/arch/ppc/boot/images/zImage.elf -ace
Kernel26.ace
>=20
> When I boot I get the following:
>=20
> loaded at:     00400000 0050719C
> board data at: 00505120 0050519C
> relocated to:  00404054 004040D0
> zimage at:     00404E40 0050484E
> avail ram:     00508000 08000000
>=20
> Linux/PPC load: console=3DttyS0,9600 ip=3Don =
root=3D/dev/sysace/disc0/part2
rw
> Uncompressing Linux...done.
> Now booting the kernel
>=20
> And then it stops.
> I'm sure I've overlooked something obvious...
> Thanks
> --
> Guillaume Dargaud
> http://www.gdargaud.net/
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev


_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
