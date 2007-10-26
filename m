Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id 84E19DDEBA
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 27 Oct 2007 05:03:37 +1000 (EST)
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "'Scott Wood'" <scottwood@freescale.com>, "Li Yang" <LeoLi@freescale.com>
Subject: RE: Porting to /arch/powerpc
Date: Fri, 26 Oct 2007 21:03:31 +0200
Message-ID: <022b01c81802$e6ba9d50$5267a8c0@Jocke>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <47222D86.1000502@freescale.com>
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
> From: Scott Wood [mailto:scottwood@freescale.com] 
> Sent: den 26 oktober 2007 20:10
> To: Joakim Tjernlund
> Cc: 'Rune Torgersen'; linuxppc-embedded@ozlabs.org
> Subject: Re: Porting to /arch/powerpc
> 
> Joakim Tjernlund wrote:
> >> The fs_enet driver doesn't currently support phy-less 
> >> directly, but you 
> >> may be able to do something with the fixed phy driver.
> > 
> > How is PHY less support supposed to be impl.? I would like
> > to do the same for ucc_geth. I once sent a patch that made
> > the PHY optional, but it never made into the driver.
> 
> Basically, the driver needs to assume the link is up if there's no 
> phy-handle in the device tree, rather than error out.
> 
> -Scott

Right, that was what I did, but I think Leo didn't want it at the time.
Leo?

 Jocke
