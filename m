Return-Path: <jdubois@mc.com>
Received: from mc.com (iris-63.mc.com [63.96.239.141])
	by ozlabs.org (Postfix) with ESMTP id 1B0452BF16
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Jan 2005 02:06:48 +1100 (EST)
From: Jean-Christophe Dubois <jdubois@mc.com>
To: Rune Torgersen <runet@innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B06DC2A@ismail.innsys.innovsys.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B06DC2A@ismail.innsys.innovsys.com>
Content-Type: text/plain
Date: Mon, 10 Jan 2005 15:56:03 +0100
Message-Id: <1105368963.535.120.camel@fr-jdubois1.ad.mc.com>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: FW: PCI "packet driver"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

One possible implementation:

- mcnet4l: http://sourceforge.net/projects/mcnet4l/

There are other available. Look at page 113 of
http://home.in.tum.de/~stodden/publications/thesis.pdf that describe
mcnet and other available implementations.

I hope it helps.

Regards

JC

On Mon, 2005-01-10 at 08:27 -0600, Rune Torgersen wrote:
>  Has anybody done a driver that will fake a ethernet connection over a
> PCI bus for connecting a host CPU to a PCI Agent CPU ?
> (in this case two 8265's, one is PCI Host and one is PCI Agent.)
> I think I saw something like that a long time ago, but have not been
> able to relocate it.
> 
> 
> Rune Torgersen
> System Developer
> Innovative Systems LLC
> 1000 Innovative Drive
> Mitchell, SD 57301
> Ph: 605-995-6120
> www.innovsys.com
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
