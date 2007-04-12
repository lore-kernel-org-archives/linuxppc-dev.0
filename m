Return-Path: <liml@rtr.ca>
Received: from mail.rtr.ca (ottawa-hs-64-26-128-89.s-ip.magma.ca
	[64.26.128.89]) by ozlabs.org (Postfix) with ESMTP id A23B4DDF4C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Apr 2007 23:43:06 +1000 (EST)
Message-ID: <461E376B.5030101@rtr.ca>
Date: Thu, 12 Apr 2007 09:43:07 -0400
From: Mark Lord <liml@rtr.ca>
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: IDE driver in polling mode
References: <1ea6be8e0704100635ydbf1538i782e796c99891e5d@mail.gmail.com>	<461B9D04.2000109@ru.mvista.com>	<20070410171125.3aeed29d@the-village.bc.nu>	<461BB8C7.9050900@garzik.org>	<20070410172942.7f63d49c@the-village.bc.nu>	<1ea6be8e0704110139i140b40b3qb8408fec2e4ff2a7@mail.gmail.com>
	<20070411094702.74774d25@the-village.bc.nu>
In-Reply-To: <20070411094702.74774d25@the-village.bc.nu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Alan Cox wrote:
> Michael <michaelzwrk@gmail.com> wrote:
> 
>> Wouldn't it work just to call ide_intr() explicitly from some polling
>> function, as Mark suggested?
> 
> No. See the ATA spec - polling command issue is subtly different.

I beg to differ, and have posted a patch to demonstrate it.

Cheers!
