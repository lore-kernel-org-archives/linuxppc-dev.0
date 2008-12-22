Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 315B3DDDEA
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Dec 2008 09:52:22 +1100 (EST)
Message-ID: <49501A14.7000201@freescale.com>
Date: Mon, 22 Dec 2008 16:52:04 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Joe Shmo <spamreceptor@yahoo.com>
Subject: Re: uboot 1.3.0 compatible with linux 2.6.21?
References: <193482.90130.qm@web30103.mail.mud.yahoo.com>
In-Reply-To: <193482.90130.qm@web30103.mail.mud.yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Joe Shmo wrote:
> I'm using a board that is a derivative of the 8313ERDB
> board.  The freescale BSP for that board included a
> patched uboot 1.1.6 that works with the 2.6.21 kernel.
[snip]
> I've changed the DTS file describing our hardware and
> recompiled it, but no luck.  I'm wondering if the
> different versions of uboot manipulate the DTS file in
> different ways and there may not be a way for these
> two versions to run together.  That's the main
> question here.

Yes, there have been some changes.  U-boot is probably looking for 
network aliases to fill in the MAC addresses.

At the very least, use a newer DTS file; better yet, use the latest 
upstream u-boot and kernel rather than anything from the BSP (unless 
there's something you really need that isn't upstream).

-Scott
