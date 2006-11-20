Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (unknown [81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C5D1367BB4
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 20 Nov 2006 23:04:21 +1100 (EST)
Date: Mon, 20 Nov 2006 12:10:15 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Stefan Roese <ml@stefan-roese.de>
Subject: Re: [PATCH] serial: Use real irq on UART0 (IRQ = 0) on PPC4xx systems
Message-ID: <20061120121015.2fb667d0@localhost.localdomain>
In-Reply-To: <200611201255.37754.ml@stefan-roese.de>
References: <200611201200.36780.ml@stefan-roese.de>
	<20061120114248.60bb0869@localhost.localdomain>
	<200611201255.37754.ml@stefan-roese.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 20 Nov 2006 12:54:32 +0100 (MET)
Stefan Roese <ml@stefan-roese.de> wrote:
> Let's see, if I got this right. You mean that on such a platform, where 0 is a 
> valid physical IRQ, we should assign another value as virtual IRQ number (not 
> 0 and not -1 of course). And then the platform "pic" implementation should 
> take care of the remapping of these virtual IRQ numbers to the physical 
> numbers.
> 
> Correct?

Absolutely correct in all the detail.
