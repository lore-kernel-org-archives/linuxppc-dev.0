Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (67-41-71-119.roch.qwest.net [67.41.71.119])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 28CD067A6F
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Apr 2005 11:59:25 +1000 (EST)
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: Wade Farnsworth <wfarnsworth@mvista.com>
In-Reply-To: <1112889944.24527.325.camel@rhino.az.mvista.com>
References: <1112808085.24527.296.camel@rhino.az.mvista.com>
	<1112808669.24673.304.camel@rhino.az.mvista.com>
	<1112808814.24527.307.camel@rhino.az.mvista.com>
	<1112835532.6160.37.camel@jdub.homelinux.org>
	<1112889944.24527.325.camel@rhino.az.mvista.com>
Content-Type: text/plain
Date: Thu, 07 Apr 2005 20:59:20 -0500
Message-Id: <1112925560.6160.41.camel@jdub.homelinux.org>
Mime-Version: 1.0
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 3/3] PPC440EP: MTD support for the Bamboo Board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 2005-04-07 at 09:05 -0700, Wade Farnsworth wrote:
> On Wed, 2005-04-06 at 17:58, Josh Boyer wrote:
> > 
> > ... so any reason why NAND_ECC_SOFT is used instead of making use of the
> > ECC registers that come with the NDFC?
> 
> Mainly because I haven't looked at what it would take to get HW ECC
> working yet.  I'll look at this when I have time, but until then at
> least the NAND flashes are functional.

Ok, I figured that was the case and you're absolutely right.  HW ECC
could be considered more of a feature, and I'd rather have usable NAND
now than have to wait longer ;).

> > 
> > Overall, I think the patch looks good.  Care to send it to the MTD
> > maintainers so it gets in their CVS tree?
> 
> Will do.

Thanks.  I gave them a heads up, so they'll be looking for it.

josh
