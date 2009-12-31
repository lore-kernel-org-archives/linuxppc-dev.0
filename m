Return-Path: <bgat@billgatliff.com>
Received: from mail-iw0-f181.google.com (mail-iw0-f181.google.com
	[209.85.223.181]) by ozlabs.org (Postfix) with ESMTP id A7C671007D1
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Dec 2009 15:19:05 +1100 (EST)
Received: by iwn11 with SMTP id 11so9448039iwn.17
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Dec 2009 20:19:04 -0800 (PST)
Message-ID: <4B3C263E.1040307@billgatliff.com>
Date: Wed, 30 Dec 2009 22:19:10 -0600
From: Bill Gatliff <bgat@billgatliff.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/1] Adds gpio_to_irq() and related support to the
	mpc52xx_gpio WKUP peripheral driver
References: <y> <1262232985-30822-1-git-send-email-bgat@billgatliff.com>
In-Reply-To: <1262232985-30822-1-git-send-email-bgat@billgatliff.com>
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
> Second, the previously-unimplemented gpio_to_irq() function was added,
> using __gpio_to_irq().  The author does not know why this code was previously
> left out of arch/powerpc/include/asm/gpio.h.  It seems to work.  The generic
> irq_to_gpio() function was not tested.
>   

Actually, I just noticed that this patch was already committed but I
hadn't pulled it in to my repo so I ended up re-discovering and
duplicating it.

The rest of the comments for this patch are accurate.


b.g.

-- 
Bill Gatliff
Embedded systems training and consulting
http://billgatliff.com
bgat@billgatliff.com
