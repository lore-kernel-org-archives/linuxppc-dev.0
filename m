Return-Path: <lagrange@fr.oleane.com>
Received: from smtp12.clb.oleane.net (smtp12.clb.oleane.net [213.56.31.47])
	by ozlabs.org (Postfix) with ESMTP id 144A467B79
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  2 Sep 2006 00:23:44 +1000 (EST)
From: "Laurent Lagrange" <lagrange@fr.oleane.com>
To: "'Bastos Fernandez Alexandre'" <alebas@televes.com>
Subject: RE: 82xx fcc_enet problem between Linux 2.4 and 2.6
Date: Fri, 1 Sep 2006 16:26:02 +0200
Message-ID: <001701c6cdd2$9221c230$5201a8c0@GEG2400>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-15"
In-Reply-To: <1157111000.44f81cd8cb6d6@webmail.televes.com:443>
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


Hello Alex,

> > I have ported Linux 2.6.9 on different boards and I noticed
> > that I have tx carrier errors on my FCC ports. Almost one
> > error per xmit.
> I have experienced same problem. I suppose you are using the old
> fcc driver in /arch/ppc
Yes that's right.

> > I reinstalled Linux 2.4.18 on these boards and I have NO ERROR.
> > The errors arise with PHY configured in 100M full duplex (or autoneg).
> > The FCC has the same duplex as PHY.
> Are you sure? In my case, the problem was that while the PHY had autoneg
> to full-duplex, the MAC kept in half-duplex mode
I have modified some code in fcc_enet.c for Linux 2.4 to manage PHY as I
wanted.
Perhaps was I in luck to correct something wrong. I checked that the duplex
were identical for FCC and PHY and I had no carrier error.

> > I think this is not a phy or hardware problem but rather a
> FCC configuration mismatch in fcc_enet.c.
> Yes. But I think the driver has been obsoleted by fs_enet one,
> so modifiying it now has no sense.
Yes I retreived fs_enet in Linux 2.6.15 and I'll try it.
This driver seems to appear in Linux 2.6.11 tree not before.
Is it right ?

Thanks very much for your reply.
Best regards
Laurent
