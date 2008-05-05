Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound4-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 89B02DDF0D
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 03:59:18 +1000 (EST)
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: jwboyer@linux.vnet.ibm.com, benh@kernel.crashing.org,
	grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org
Subject: [PATCH 0/4] [v4][POWERPC] refactor dcr code
Date: Mon,  5 May 2008 10:56:37 -0700
In-Reply-To: <20080421080353.5d2b3bb9@zod.rchland.ibm.com>
References: <20080421080353.5d2b3bb9@zod.rchland.ibm.com>
Message-Id: <20080505175647.B767E18D8052@mail79-sin.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I've modified these patches to include Josh's comments, and also
modified the tft patches to not assume that patches to ARCH=ppc are
made.  This breaks platform_device support and hence ARCH=ppc support.
I'd appreciate it if these patches could get queued up for 2.6.27 (and
hence get built a bit before then), when ARCH=ppc is going away
anyway.

Steve
