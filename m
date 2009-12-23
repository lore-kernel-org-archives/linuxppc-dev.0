Return-Path: <bgat@billgatliff.com>
Received: from mail-gx0-f228.google.com (mail-gx0-f228.google.com
	[209.85.217.228]) by ozlabs.org (Postfix) with ESMTP id 07C38B7B71
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Dec 2009 03:47:14 +1100 (EST)
Received: by gxk28 with SMTP id 28so1207356gxk.9
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Dec 2009 08:47:12 -0800 (PST)
Message-ID: <4B3249AA.50405@billgatliff.com>
Date: Wed, 23 Dec 2009 10:47:38 -0600
From: Bill Gatliff <bgat@billgatliff.com>
MIME-Version: 1.0
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: Does gpio_to_irq() work for MPC52xx gpios?
References: <4B312EDA.7030606@billgatliff.com>
	<87fx72wwpd.fsf@macbook.be.48ers.dk>
In-Reply-To: <87fx72wwpd.fsf@macbook.be.48ers.dk>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Peter Korsgaard wrote:
>
> No (not yet). In Ben's latest pull request there's a patch from me to
> add basic infrastructure for gpio_to_irq(). I've recently added irq
> support to the mpc8xxx driver, but so far nothing has been written for
> 52xx.
>
> http://patchwork.ozlabs.org/patch/41550/
>   

Ok.  I'm taking a look at that code now, planning to adapt it for the
MPC52xx unless someone raises any objections.


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com
