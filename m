Return-Path: <alebas@televes.com>
Received: from tvesnat.televes.com (unknown [212.163.42.137])
	by ozlabs.org (Postfix) with ESMTP id B6D08679A6
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Sep 2006 21:46:26 +1000 (EST)
Message-ID: <1157111000.44f81cd8cb6d6@webmail.televes.com:443>
Date: Fri,  1 Sep 2006 13:43:20 +0200
From: Bastos Fernandez Alexandre <alebas@televes.com>
To: Laurent Lagrange <lagrange@fr.oleane.com>
Subject: Re: 82xx fcc_enet problem between Linux 2.4 and 2.6
References: <002101c6cd25$6945e470$5201a8c0@GEG2400>
In-Reply-To: <002101c6cd25$6945e470$5201a8c0@GEG2400>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
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

Laurent,

>
> I work on several custom 82xx boards with Linux 2.4 and 2.6.
>
> I have ported Linux 2.6.9 on different boards and I noticed
> that I have tx carrier errors on my FCC ports. Almost one
> error per xmit.
>

I have experienced same problem. I suppose you are using the old
fcc driver in /arch/ppc

> I reinstalled Linux 2.4.18 on these boards and I have NO ERROR.
>
> The errors arise with PHY configured in 100M full duplex (or autoneg).
> The FCC has the same duplex as PHY.

Are you sure? In my case, the problem was that while the PHY had autoneg
to full-duplex, the MAC kept in half-duplex mode

> [...]
>
> I think this is not a phy or hardware problem but rather a FCC configuration
> mismatch in fcc_enet.c.
>

Yes. But I thing the driver has been obsoleted by fs_enet one,
so modifiying it now has no sense.

Best regards,

Alex BASTOS
