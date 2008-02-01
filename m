Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D22C9DDFC1
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  2 Feb 2008 06:53:31 +1100 (EST)
Date: Fri, 1 Feb 2008 13:53:24 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: Steven Hein <ssh@sgi.com>
Subject: Re: 8360 custom board, ucc_geth TX errors on longer(?) packets
Message-Id: <20080201135324.8372268e.kim.phillips@freescale.com>
In-Reply-To: <47A36A69.1010809@sgi.com>
References: <47A36A69.1010809@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Fri, 01 Feb 2008 12:52:25 -0600
Steven Hein <ssh@sgi.com> wrote:

> The one main difference in this board is how eth0 is wired.
> We have a Broadcom GbE switch part, and UCC1 eth is wired
> directly to that switch (no PHY).   (This where I needed to

sounds like you ran into some h/w errata.  if on rgmii, you might
want to find a way to program the switch for rgmii with internal delay
(8360 rev.2 rgmii-id rx & tx; 8360rev2.1 rgmii-rxid (i.e. for rx
only)).  If not, I'd contact fsl tech support directly.

Kim
