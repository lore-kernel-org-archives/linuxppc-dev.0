Return-Path: <bgat@billgatliff.com>
Received: from mail-yx0-f178.google.com (mail-yx0-f178.google.com
	[209.85.210.178]) by ozlabs.org (Postfix) with ESMTP id EB949B7BF7
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Dec 2009 17:52:02 +1100 (EST)
Received: by yxe8 with SMTP id 8so8433844yxe.17
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Dec 2009 22:52:01 -0800 (PST)
Message-ID: <4B330FAA.1070909@billgatliff.com>
Date: Thu, 24 Dec 2009 00:52:26 -0600
From: Bill Gatliff <bgat@billgatliff.com>
MIME-Version: 1.0
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: Does gpio_to_irq() work for MPC52xx gpios?
References: <4B312EDA.7030606@billgatliff.com>
	<87fx72wwpd.fsf@macbook.be.48ers.dk>
	<4B3249AA.50405@billgatliff.com> <4B327FEC.9030801@billgatliff.com>
	<4B32FE43.1030905@billgatliff.com>
In-Reply-To: <4B32FE43.1030905@billgatliff.com>
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

Bill Gatliff wrote:
> Guys:
>
>
> Ok, I have gpio_to_irq() more-or-less showing signs of life for the
> MPC5200.  But I'm having some trouble using it the way I want to.
>   

I think I've got the idea all of a sudden.

In order to describe the inputs to my rotary encoder using the syntax I
want, I have to implement something similar to of_get_gpio_flags(), right?


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com
