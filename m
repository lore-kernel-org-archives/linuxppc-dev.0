Return-Path: <matthias.fuchs@esd-electronics.com>
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net
	[151.189.21.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A7E31DDE0E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Sep 2007 19:13:55 +1000 (EST)
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: PCI target implementation on AMCC PPC CPUs
Date: Tue, 11 Sep 2007 11:13:46 +0200
References: <556445368AFA1C438794ABDA8901891C06460054@USA0300MS03.na.xerox.net>
	<406A31B117F2734987636D6CCC93EE3C022417D2@ehost011-3.exch011.intermedia.net>
	<46E06259.5010305@ovro.caltech.edu>
In-Reply-To: <46E06259.5010305@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709111113.46508.matthias.fuchs@esd-electronics.com>
Cc: Leonid <Leonid@a-k-a.net>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi David,

we build a couple of PCI target designs using AMCC PowerPCs.
You are right that some things could be better. But ..

On Thursday 06 September 2007 22:26, David Hawkins wrote:
> There are several fundamental problems with the AMCC 440EP
> acting as a PCI target/slave;
> 
> 2. Look in the data sheet and see if you can figure out
>     how the host processor can generate an interrupt to
>     the PowerPC core ... oops, you can't. That kind of
>     makes it difficult to work with doesn't it.
You CAN! You can generate an interrupt to the PowerPC from the host
CPU bei writing to the PCI command register. You have to read the user manual
carefully. Perhaps it not that obvious.

Matthias
