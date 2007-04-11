Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from the-village.bc.nu (unknown [81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 246FBDDFEA
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Apr 2007 18:43:59 +1000 (EST)
Date: Wed, 11 Apr 2007 09:47:02 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Michael <michaelzwrk@gmail.com>
Subject: Re: IDE driver in polling mode
Message-ID: <20070411094702.74774d25@the-village.bc.nu>
In-Reply-To: <1ea6be8e0704110139i140b40b3qb8408fec2e4ff2a7@mail.gmail.com>
References: <1ea6be8e0704100635ydbf1538i782e796c99891e5d@mail.gmail.com>
	<461B9D04.2000109@ru.mvista.com>
	<20070410171125.3aeed29d@the-village.bc.nu>
	<461BB8C7.9050900@garzik.org>
	<20070410172942.7f63d49c@the-village.bc.nu>
	<1ea6be8e0704110139i140b40b3qb8408fec2e4ff2a7@mail.gmail.com>
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

On Wed, 11 Apr 2007 10:39:58 +0200
Michael <michaelzwrk@gmail.com> wrote:

> Doesn't libata have to do with SCSI devices? I'm afraid it wouldn't
> work with CF, which is P-ATA compatible.

libata drives PATA and SATA devices, including CF.

> Wouldn't it work just to call ide_intr() explicitly from some polling
> function, as Mark suggested?

No. See the ATA spec - polling command issue is subtly different.

Alan
