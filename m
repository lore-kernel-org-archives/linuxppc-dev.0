Return-Path: <dan@embeddedalley.com>
Received: from smtp107.biz.mail.re2.yahoo.com (smtp107.biz.mail.re2.yahoo.com
	[206.190.52.176]) by ozlabs.org (Postfix) with SMTP id 5412EDDECF
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 05:21:23 +1000 (EST)
In-Reply-To: <4613EAC6.5000203@freescale.com>
References: <11756161753280-git-send-email-timur@freescale.com>
	<F4B76190-37C3-453C-B4F0-C1CB7CC0532E@kernel.crashing.org>
	<4613E39A.70606@freescale.com> <4613E7CC.1020001@246tNt.com>
	<4613EAC6.5000203@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5BBB288E-3E8D-4513-B75A-101CC8950F86@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: [PATCH] powerpc: change rheap functions to use long integers
	instead of pointers
Date: Wed, 4 Apr 2007 15:15:01 -0400
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Sylvain Munaut <tnt@246tNt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 4, 2007, at 2:13 PM, Timur Tabi wrote:

> How about I change rh_alloc() to return unsigned long, instead of  
> just long, and then the
> callers can use IS_ERR_VALUE() to check for error?

How about just leaving it alone?  A void * is
perfectly valid as rheap could be used to manage
any address space.  It isn't a bug, you are reducing
it's capability (by taking it's object management
outside of the kernel virtual space), and you are
introducing concerns for error conditions of
current users.

Thanks.


	-- Dan
