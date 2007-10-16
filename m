Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound8-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2347BDDE34
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 09:24:09 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v2] Device tree bindings for Xilinx devices
Date: Tue, 16 Oct 2007 16:23:39 -0700
In-Reply-To: <20071015155223.7403.39615.stgit@trillian.cg.shawcable.net>
References: <20071015155223.7403.39615.stgit@trillian.cg.shawcable.net>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>, <linuxppc-dev@ozlabs.org>,
	"Wolfgang Reissnegger" <wre@xilinx.com>, "Leonid" <Leonid@a-k-a.net>,
	<microblaze-uclinux@itee.uq.edu.au>
Message-Id: <20071016232404.5F4D51130091@mail133-blu.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


It occurs to me that the 'compatible' bindings should probably be the
name of the preferred driver for the device.=20

> +   l) Xilinx ML300 Framebuffer
> +    - compatible : Must include "xilinx,ml300-fb"
Should probably be 'xilinxfb', and probably shouldn't reference ML300 at
all.

> +   n) Xilinx EMAC and Xilinx TEMAC
> +
> +   Xilinx Ethernet devices.  Uses common properties from=20
> other Ethernet
> +   devices with the following constraints:
> +  =20
> +   Required properties:
> +    - compatible : Must include one of: "xilinx,plb-temac",
> +                   "xilinx,plb-emac", "xilinx-opb-emac"
Should probably be just 'emac' and 'temac'.

This should be possible to extract using Michel Simek's EDK-integrated
device tree generator.  The compatibility information is stored in the
EDK driver's .mdd file (although this is somewhat backwards from what
one might expect).

Steve
