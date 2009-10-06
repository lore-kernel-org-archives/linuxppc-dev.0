Return-Path: <thomas.rinder@automationtechnology.de>
Received: from mo-p00-ob.rzone.de (mo-p00-ob.rzone.de [81.169.146.160])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 97A83B7B7E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  6 Oct 2009 19:29:06 +1100 (EST)
Received: from AT-THOMAS3 (p50999650.dip0.t-ipconnect.de [80.153.150.80])
	by post.strato.de (fruni mo37) (RZmta 22.1)
	with (AES128-SHA encrypted) ESMTP id 405740l9683lKj
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 6 Oct 2009 10:29:00 +0200 (MEST)
From: "Thomas Rinder" <thomas.rinder@automationtechnology.de>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: XILINX  memory layout <-> physical memory
Date: Tue, 6 Oct 2009 10:29:44 +0100
Message-ID: <001901ca4667$8ac93b60$a05bb220$@rinder@automationtechnology.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Betreff: XILINX memory layout <-> physical memory

Hello,

I'm newbie in PPCLinux, don't know I'm right here.

I made a ports to an AVNET FX12 minimodul and custom board (FX40/FX60) =
based
on linuxppc found on http://git.xilinx.com/ (ppc405 processor).

All works fine, but I can use/configure only the half memory size =
available
in the dts (for instance 32Mbytes of 64Mbytes on Avnet minimodul).
Otherwise the kernel crashes if tries to mount the root file system =
(ext2
ramdisk).

I expect my problem is the physical memory layout and its control. I =
want to
understand and control the physical memory layout.

But I didn't not found documentation how the memory layout is organized =
in
linuxppc and
how do I control were kernel, ramdisk etc. resides in physical memory.

Could anyone give me a hint please, how-to start?

Thanks a lot,

Thomas

Ausgehende eMail ist virenfrei.
Von AVG =FCberpr=FCft - www.avg.de=20
Version: 8.5.420 / Virendatenbank: 270.14.4/2416 - Ausgabedatum: =
10/05/09
18:23:00=20

Ausgehende eMail ist virenfrei.
Von AVG =FCberpr=FCft - www.avg.de=20
Version: 8.5.420 / Virendatenbank: 270.14.4/2416 - Ausgabedatum: =
10/05/09
18:23:00=20
