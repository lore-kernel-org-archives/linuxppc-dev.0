Return-Path: <dan@embeddedalley.com>
Received: from smtp107.biz.mail.re2.yahoo.com (smtp107.biz.mail.re2.yahoo.com
	[206.190.52.176]) by ozlabs.org (Postfix) with SMTP id 19773DDEFF
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Feb 2007 04:13:37 +1100 (EST)
In-Reply-To: <989B956029373F45A0B8AF02970818900D444B@zch01exm26.fsl.freescale.net>
References: <989B956029373F45A0B8AF02970818900D444B@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3EDDA705-0482-4E19-ABEA-4CD186185C14@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: Discussion about iopa()
Date: Fri, 9 Feb 2007 12:06:55 -0500
To: Li Yang-r58472 <LeoLi@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Tabi Timur-B04825 <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 8, 2007, at 4:22 AM, Li Yang-r58472 wrote:

> Do you think we should remove iopa?

I'm surprised it's still around :-)  I had to fight hard many
years ago to implement it, since I found it very useful
for complex mappings we needed to manage uncached
spaces for the MPC8xx.

> The information is often not so obvious. ...

I agree with you.  Linux has the weirdest set
(or lack of) VM APIs I've ever seen, to the point
of preventing useful mapping or tracking
attributes.  Good luck with your argument to
use useful functions, you have at least
one person on your side :-)


	-- Dan
