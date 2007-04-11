Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from the-village.bc.nu (unknown [81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 66FC7DDF0D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Apr 2007 01:20:12 +1000 (EST)
Date: Wed, 11 Apr 2007 16:23:16 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Michael <michaelzwrk@gmail.com>
Subject: Re: IDE driver in polling mode
Message-ID: <20070411162316.41a913e6@the-village.bc.nu>
In-Reply-To: <1ea6be8e0704110810l205f5dc7gb831603455a883e2@mail.gmail.com>
References: <1ea6be8e0704100635ydbf1538i782e796c99891e5d@mail.gmail.com>
	<461B9D04.2000109@ru.mvista.com>
	<20070410171125.3aeed29d@the-village.bc.nu>
	<461BB8C7.9050900@garzik.org>
	<20070410172942.7f63d49c@the-village.bc.nu>
	<1ea6be8e0704110139i140b40b3qb8408fec2e4ff2a7@mail.gmail.com>
	<20070411094702.74774d25@the-village.bc.nu>
	<1ea6be8e0704110810l205f5dc7gb831603455a883e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 11 Apr 2007 17:10:12 +0200
Michael <michaelzwrk@gmail.com> wrote:

> I see.
> The problem is I am constrained to 2.6.14 kernel.

Make sure you backport any relevant network security fixes in that case.

If you are working to 2.6.14, then your easiest route may be to write a
polling CF driver from scratch. If you only have to support PIO and you
only do ATA not ATAPI then it isn't a large amount of code.

Alan
