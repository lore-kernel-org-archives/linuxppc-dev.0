Message-ID: <3A2E3C99.C9B6CC2C@rd.francetelecom.fr>
Date: Wed, 06 Dec 2000 14:18:17 +0100
From: FASSINO Jean-Philippe <jeanphilippe.fassino@rd.francetelecom.fr>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Promiscuous mode & Link change
References: <3A2E1430.84036697@rd.francetelecom.fr> <19341031051139.14747@192.168.1.2>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:

> >When using network card in promiscious mode and when link
> >change (down or speed),  the promiscious mode is reset and
> >card not stay in promiscious mode.
> >
> >Is it normal, or is it a feature not managed by Linux ?
>
> This depends on the network chip driver. Which card have you
> seen this with ?

This occur on a DEC 21143 chip with Tulip drivers.
But this seem to not occure on  internal GMAC card.
May be i'm not posting problem on goot list ?

JP


--
--------------------------------------------------------------------------
 Jean-Philippe FASSINO              France Telecom R&D : DTL/ASR
 Tel : 04 76 76 45 52
 mailto:jeanphilippe.fassino@rd.francetelecom.fr
--------------------------------------------------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
