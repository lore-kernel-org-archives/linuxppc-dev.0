Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id B6F2BB714F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Sep 2010 06:04:37 +1000 (EST)
Date: Thu, 2 Sep 2010 13:04:34 -0700
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: linuxppc-dev@lists.ozlabs.org
Subject: Where to put board-specific drivers
Message-ID: <20100902200434.GC24861@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello all,

I've written several drivers for a custom board. The board is basically
an mpc8349_mds board with some extra FPGAs for data processing.

All of the drivers were written to interface with a custom system
controller FPGA, which handles things like LED control, FPGA
programming, and fast data dumping from the data processing FPGAs.

I'd like to start pushing some of these drivers into mainline, but I
don't know where to put them. I don't think drivers/ is appropriate:
these are highly board specific. Does arch/powerpc/ have a recommended
place for board-specific drivers? I was thinking about
arch/powerpc/drivers/, however that doesn't exist.

Thanks,
Ira
