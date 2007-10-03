Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EC8FBDDDF4
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 08:42:03 +1000 (EST)
In-Reply-To: <4703D8B9.5080006@freescale.com>
References: <1191429299378-git-send-email-timur@freescale.com>
	<20071003094449.702c4a90@freepuppy.rosehill>
	<4703D8B9.5080006@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B596192A-5A72-463A-A927-312FC6FA35DA@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v4] qe: miscellaneous code improvements and fixes to the
	QE library
Date: Wed, 3 Oct 2007 17:41:58 -0500
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org,
	Stephen Hemminger <shemminger@linux-foundation.org>, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 3, 2007, at 1:00 PM, Timur Tabi wrote:

> Stephen Hemminger wrote:
>
>> Separate the changes into individual patches to allow for better  
>> comment/review
>> and bisection in case of regression.
>
> That would be too difficult.  Some of the changes are single lines,  
> and this patch has already been approved -- I just cross-posted to  
> netdev because I made a few ucc_geth changes that can't be  
> docoupled from the powerpc changes.  A series of 18 patches would  
> just be convoluted.

Normally I would agree, but at this point I'm not going to gripe too  
much about it.

- k
