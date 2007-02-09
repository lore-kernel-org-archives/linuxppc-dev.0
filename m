Return-Path: <dan@embeddedalley.com>
Received: from smtp106.biz.mail.re2.yahoo.com (smtp106.biz.mail.re2.yahoo.com
	[206.190.52.175]) by ozlabs.org (Postfix) with SMTP id 11C49DDF1D
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Feb 2007 04:14:56 +1100 (EST)
In-Reply-To: <45CB28A6.3050607@freescale.com>
References: <989B956029373F45A0B8AF02970818900D444B@zch01exm26.fsl.freescale.net>
	<45CB28A6.3050607@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <712E63F6-23D6-45EB-92F0-95656FF38BC4@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: Discussion about iopa()
Date: Fri, 9 Feb 2007 12:08:15 -0500
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 8, 2007, at 8:41 AM, Timur Tabi wrote:

> Walking the page table is slower than using pointer math, so you  
> want to
> avoid iopa() if you can.

Big deal.  With all of the other kernel bloat
going on you want to argue about a couple
of memory accesses?  :-)

	-- Dan
