Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id B8069DDDFB
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Oct 2007 08:38:29 +1000 (EST)
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "'Scott Wood'" <scottwood@freescale.com>,
	"'Rune Torgersen'" <runet@innovsys.com>
Subject: RE: Porting to /arch/powerpc
Date: Fri, 26 Oct 2007 00:26:17 +0200
Message-ID: <020001c81756$0fc78760$5267a8c0@Jocke>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <472113CC.5020409@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: 
> linuxppc-embedded-bounces+joakim.tjernlund=lumentis.se@ozlabs.
> org 
> [mailto:linuxppc-embedded-bounces+joakim.tjernlund=lumentis.se
> @ozlabs.org] On Behalf Of Scott Wood
> Sent: den 26 oktober 2007 00:08
> To: Rune Torgersen
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: Porting to /arch/powerpc
> 
> Rune Torgersen wrote:
> > Is there a good platform/documents to look at for doing a board port
> > from arch/ppc to arch/powerpc?
> > I'm porting a 8266/8280 based board with PCI and 2 FCC ethernets
> > connected phy-less to a switch.
> 
> Look at head-of-tree for 82xx stuff (lots of changes since 2.6.23)... 
> any of the 82xx boards in arch/powerpc should be good to look at.
> 
> The fs_enet driver doesn't currently support phy-less 
> directly, but you 
> may be able to do something with the fixed phy driver.

How is PHY less support supposed to be impl.? I would like
to do the same for ucc_geth. I once sent a patch that made
the PHY optional, but it never made into the driver.

   Jocke

> 
> -Scott
