Return-Path: <wd@denx.de>
Received: from mailout03.sul.t-online.com (mailout03.sul.t-online.com
	[194.25.134.81]) by ozlabs.org (Postfix) with ESMTP id AE68867A8D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Mar 2005 08:18:51 +1100 (EST)
To: Jason McMullan <jason.mcmullan@timesys.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 22 Mar 2005 15:27:49 EST."
	<1111523269.2987.58.camel@ad.doubleclick.net>
Date: Tue, 22 Mar 2005 22:18:34 +0100
Sender: wd@denx.de
Message-Id: <20050322211839.6A3DCC1510@atlas.denx.de>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] CPM2 cleanups 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <1111523269.2987.58.camel@ad.doubleclick.net> you wrote:
> 
...
> +static unsigned int cpm2_startup_irq(unsigned int irq)
> +{  
> +       cpm2_unmask_irq(irq);
> +       return 0;
> +}
> +
> +static void cpm2_shutdown_irq(unsigned int irq)
> +{
> +       cpm2_mask_irq(irq);
> +}

Why is cpm2_startup_irq() not void like cpm2_shutdown_irq() ?

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Overflow on /dev/null, please empty the bit bucket.
