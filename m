Return-Path: <jjboor@aimsys.nl>
Received: from linserv001.aimsys.nl (a80-127-156-242.adsl.xs4all.nl
	[80.127.156.242])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 730BC2BDA1
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Sep 2004 18:50:43 +1000 (EST)
From: Jaap-Jan Boor <jjboor@aimsys.nl>
To: alebas@televes.com
In-Reply-To: <1096380738.415971420df80@webmail.televes.com:443>
References: <1096380738.415971420df80@webmail.televes.com:443>
Content-Type: text/plain
Message-Id: <1096446806.32438.5.camel@linpc003.aimsys.nl>
Mime-Version: 1.0
Date: Wed, 29 Sep 2004 10:33:27 +0200
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Full duplex, MDIO and both Ethernet in MPC8272ADS
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On di, 2004-09-28 at 16:12, alebas@televes.com wrote:
> Hi to all,
> 
> As long as I have seen (tested and surfed in the code), current
> linuxppc_2.4.26_devel support for MPC8272ADS board is limited to one PHY,
> without MII management support and the interface is always configured as Half
> Duplex. Unfourtunately, this is little useful for me, as long as i am trying to
> set up a bridge between both interfaces.
> 
> I have been also testing the Linux Reference Design, from Arabella SW, which, as
> long as I have seen, has support for both PHYs, MII management and Full Duplex.
> 
> So, is there any plan to merge any of Arabella's changes into the ppc tree? Or
> is there anyone currently working on that ethernet stuff for current 2.4.26
> tree? Is  it planned to provide a patch soon?

I use the fcc enet driver and a dual port phy using the fcc driver's mii
implementation on a 8270, but on a propietary board design.

Jaap-Jan

> 
> Best regards,
> 
> Alex.
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
