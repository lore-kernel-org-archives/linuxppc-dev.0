Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7432FDE151
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 23:44:01 +1000 (EST)
Message-Id: <D70F79B4-BA5F-46D4-9D74-4CB2E375AF60@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20080625215051.GA11784@loki.buserror.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH 1/3] mpc83xx: Power Management support
Date: Thu, 26 Jun 2008 08:43:52 -0500
References: <20080625215051.GA11784@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 25, 2008, at 4:50 PM, Scott Wood wrote:

> Basic PM support for 83xx.  Standby is implemented as sleep.
> Suspend-to-RAM is implemented as "deep sleep" (with the processor
> turned off) on 831x.  PCI agent power management is supported.
>
> Device power management of SOC peripherals is not yet supported.

(Not comments on this patch, but related)

Do you know if anyone is looking at making sure DOZE/NAP work on  
83xx?  We clearly don't flush the L1 cache today in the 6xx code.

- k
