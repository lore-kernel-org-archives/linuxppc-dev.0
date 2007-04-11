Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (147.175.241.83.in-addr.dgcsystems.net
	[83.241.175.147]) by ozlabs.org (Postfix) with ESMTP id 4A18ADDEFC
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 07:57:57 +1000 (EST)
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "'Kim Phillips'" <kim.phillips@freescale.com>,
	<linuxppc-dev@ozlabs.org>
Subject: RE: [PATCH 1/4] powerpc: document max-speed and interface-type
	properties
Date: Wed, 11 Apr 2007 23:45:36 +0200
Message-ID: <006a01c77c82$bd304b40$6667a8c0@Jocke>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20070410165639.1b619c34.kim.phillips@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: 
> linuxppc-dev-bounces+joakim.tjernlund=transmode.se@ozlabs.org 
> [mailto:linuxppc-dev-bounces+joakim.tjernlund=transmode.se@ozl
> abs.org] On Behalf Of Kim Phillips
> Sent: den 10 april 2007 23:57
> To: linuxppc-dev@ozlabs.org
> Subject: [PATCH 1/4] powerpc: document max-speed and 
> interface-type properties
> 
> Since ucc_geth is being migrated to use the phylib, the existing
> (undocumented) 'interface' property is being deprecated in favour
> of unconjoined variations 'max-speed' and 'interface-type'.
> 
> max-speed is necessary for QE UEC devices that do not make that
> information available through their programming model.
> 
> interface-type is now maintained one-to-one with definitions
> in include/linux/phy.h.
> 
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> ---
> please consider for 2.6.22
> 
>  Documentation/powerpc/booting-without-of.txt |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/powerpc/booting-without-of.txt 
> b/Documentation/powerpc/booting-without-of.txt
> index 88cdb59..92fa74c 100644
> --- a/Documentation/powerpc/booting-without-of.txt
> +++ b/Documentation/powerpc/booting-without-of.txt
> @@ -1556,6 +1556,9 @@ platforms are moved over to use the 
> flattened-device-tree model.
>     Required properties for network device_type:
>     - mac-address : list of bytes representing the ethernet address.
>     - phy-handle : The phandle for the PHY connected to this 
> controller.
> +   - max-speed : The maximum speed supported by the 
> controller (in Mbit/s)
> +   - interface-type : a string naming the controller/PHY 
> interface type,
> +     i.e., one of "mii", "gmii", "sgmii", "tbi", "rmii", 
> "rgmii", or "rtbi".

Hmm, what if I have a direct MII to MII connection without a PHY in between?
Will this support such a "fixed" connection?
How do I express that in OF speak?

 Jocke
