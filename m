Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 329B8DDE1F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Sep 2008 08:06:28 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m8NM6NFV012426 for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Sep 2008 15:06:23 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m8NM6MJZ004544
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Sep 2008 17:06:22 -0500 (CDT)
Date: Tue, 23 Sep 2008 17:06:21 -0500
From: Scott Wood <scottwood@freescale.com>
To: VenkataKrishna <venkatakrishnap@vrindatech.com>
Subject: Re: Linux problem in mpc8260
Message-ID: <20080923220621.GD9984@ld0162-tx32.am.freescale.net>
References: <20080922121905.82B33DDEDD@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080922121905.82B33DDEDD@ozlabs.org>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Sep 22, 2008 at 05:37:24PM +0530, VenkataKrishna wrote:
>  In our target board have two banks of flash device. Which is connected two
> Chip select 0(CS0) and Chip select 1 (CS1). In Hardware our target board has
> specialty   jumper setting change CS0 VsCS1. Booting device always connected
> CS0. What is our problem is I want download my Linux uImage in one of flash
> device in my board when change jumper setting in hardware the board should
> be boot .Board  is Powerpc based processor (MPC8260). Any one suggest me
> what can I do. Where can I initialization memory device. 

You need to put a u-boot (or other firmware) image in each bank.

-Scott
