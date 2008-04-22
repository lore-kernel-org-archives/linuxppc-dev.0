Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 25D9FDE3A1
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 03:23:11 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m3MHN7jX012343
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 10:23:07 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m3MHN6ar014422
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 12:23:06 -0500 (CDT)
Date: Tue, 22 Apr 2008 12:23:06 -0500
From: Scott Wood <scottwood@freescale.com>
To: Andre Schwarz <andre.schwarz@matrix-vision.de>
Subject: Re: Question on MPC83xx interrupts
Message-ID: <20080422172306.GA17992@ld0162-tx32.am.freescale.net>
References: <480E1939.6000701@matrix-vision.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <480E1939.6000701@matrix-vision.de>
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 22, 2008 at 06:58:33PM +0200, Andre Schwarz wrote:
> I wonder if the IRQ number should match the vector of the datasheet ... 
> giving :

No.  The numbers in /proc/interrupts are virtual IRQ numbers, which are a
purely Linux-internal construct.

-Scott
