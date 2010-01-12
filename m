Return-Path: <bgat@billgatliff.com>
Received: from mail-qy0-f198.google.com (mail-qy0-f198.google.com
	[209.85.221.198]) by ozlabs.org (Postfix) with ESMTP id 7C7631007D4
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jan 2010 03:50:13 +1100 (EST)
Received: by qyk36 with SMTP id 36so270982qyk.15
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jan 2010 08:50:11 -0800 (PST)
Message-ID: <4B4CA844.8040301@billgatliff.com>
Date: Tue, 12 Jan 2010 10:50:12 -0600
From: Bill Gatliff <bgat@billgatliff.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: Sleep-capable GPIO slave-selects on MPC52xx?
References: <4B4B866B.10207@billgatliff.com>
In-Reply-To: <4B4B866B.10207@billgatliff.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Bill Gatliff wrote:
>
> It looks like the current version of the MPC52xx SPI driver won't work
> with sleep-capable GPIOs for slave-selects.  In particular, it looks
> like mpc52xx_spi_fsmstate_transfer() is an interrupt handler that calls
> mpc52xx_spi_chipsel(), which itself calls gpio_set_value().  Or, at
> least my kernel thinks so, since I get a barrage of oops-type output
> screaming at me whenever I hit the SPI device.  :)
>
> Am I missing something, or is this a known (or at least now-identified)
> limitation of the current mpc52xx_spi.c?
>   

So, nobody has any feedback on this?  :)

Would using a threaded handler for the SPI interrupts be likely to work
here?


b.g.

-- 
Bill Gatliff
Embedded systems training and consulting
http://billgatliff.com
bgat@billgatliff.com
