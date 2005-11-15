Return-Path: <rmk+linuxppc-embedded=ozlabs.org@arm.linux.org.uk>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 348EB6878F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Nov 2005 06:07:33 +1100 (EST)
Received: from [2002:d412:e8ba::1] (helo=caramon.arm.linux.org.uk)
	by parcelfarce.linux.theplanet.co.uk with esmtpsa
	(TLSv1:DES-CBC3-SHA:168) (Exim 4.43) id 1Ec69G-0001jA-KO
	for linuxppc-embedded@ozlabs.org; Tue, 15 Nov 2005 19:07:19 +0000
Date: Tue, 15 Nov 2005 19:06:55 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrey Volkov <avolkov@varma-el.com>
Message-ID: <20051115190655.GA10892@flint.arm.linux.org.uk>
References: <437A2EE8.4050404@varma-el.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <437A2EE8.4050404@varma-el.com>
Sender: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org,
	ML linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 1/1 kernel 2.6.15-rc1] Fix copy-paste bug after _Convert
	platform drivers to use_ (again)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Nov 15, 2005 at 09:54:32PM +0300, Andrey Volkov wrote:
> Hello Russell,
> 
> I fear it is not a last patch of such kind :(.
> Please recheck places where you are changed
> pdev<->dev.

Either that will have to wait a number of days or someone else will
have to do that.  I'm sorry but I'm rather unwell and in no fit state
to do anything major with kernels atm.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
