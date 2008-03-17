Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound4-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id B190CDDF8B
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 04:36:54 +1100 (EST)
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: grant.likely@secretlab.ca, git-dev@xilinx.com,
	linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Xilinx hwicap updates
Date: Mon, 17 Mar 2008 10:36:29 -0700
Message-Id: <20080317173646.D512A1010058@mail4-dub.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following sequence of patches makes the icap driver more robust,
by making better use of the status information from the cores.  In
addition, Lanana has assigned Major 259 for FPGA configuration
interfaces, so we now use it, rather than dynamically finding a major
number.

Grant: please pick these up for 2.6.26.  Do you think it's worth
patching virtex_devices.c at this point, or just punt on ARCH=ppc?

Steve
