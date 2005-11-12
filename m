Return-Path: <rmk+linuxppc-embedded=ozlabs.org@arm.linux.org.uk>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 859C868734
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 13 Nov 2005 09:05:54 +1100 (EST)
Received: from [2002:d412:e8ba::1] (helo=caramon.arm.linux.org.uk)
	by parcelfarce.linux.theplanet.co.uk with esmtpsa
	(TLSv1:DES-CBC3-SHA:168) (Exim 4.43) id 1Eb3US-0004m8-9v
	for linuxppc-embedded@ozlabs.org; Sat, 12 Nov 2005 22:04:52 +0000
Date: Sat, 12 Nov 2005 22:04:33 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrey Volkov <avolkov@varma-el.com>
Message-ID: <20051112220433.GK28987@flint.arm.linux.org.uk>
References: <4375E765.4000207@varma-el.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4375E765.4000207@varma-el.com>
Sender: Russell King <rmk@arm.linux.org.uk>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
	ML linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 1/1 kernel 2.6.15-rc1] Fix copy-paste bug in
	mpc52xx_uart.c (pdev<->dev)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sat, Nov 12, 2005 at 04:00:21PM +0300, Andrey Volkov wrote:
> Fix copy-paste bug in mpc52xx_uart.c (pdev<->dev)

Applied, thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
