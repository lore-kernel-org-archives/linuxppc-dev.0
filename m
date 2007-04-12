Return-Path: <Bruce_Leonard@selinc.com>
Received: from duster.selinc.com (duster.selinc.com [12.110.71.38])
	by ozlabs.org (Postfix) with ESMTP id 30776DDF51
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Apr 2007 03:43:48 +1000 (EST)
In-Reply-To: <20070412193658.06a958be@vitb.ru.mvista.com>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: Re: Still trying to get a stable 2.6.20.4 running on 8349ITX eval
	board
MIME-Version: 1.0
Message-ID: <OFB7724E04.92BE940D-ON882572BB.00610090-882572BB.0061632F@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Thu, 12 Apr 2007 10:43:43 -0700
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Vitaly,

Vitaly Bordug <vbordug@ru.mvista.com> wrote on 04/12/2007 08:36:58 AM:

> 
> It worked for me with both MontaVista and ELDK rfs for 6xx.
> 
> Your problem looks very much like odd DDR or memctl misconfiguration
> early in u-boot.
>

Ed made a similar observation.  I've been assuming ;) that the DDR RAM was 
configured correctly since it's been a 'supported' eval board since at 
least u-boot 1.1.6, but there may be a problem there.  At least I'm going 
to make sure that it's all okay before I continue.
 
> Also, there is Vitesse switch on this target, which should be 
> initialized(Normally with vendor-shipped image you'll figure out how
> by print thirdp_init. Starting kernel without that may result in 
> some instability too.

Thanks.  Again I was assuming all the HW was correctly configured with 
u-boot.  I'll dig into this as well.  Soon as I find anything for sure 
I'll post a follow up.

Bruce

------------------------------------------------

This e-mail may contain SEL confidential information.  The opinions
expressed are not necessarily those of SEL.  Any unauthorized disclosure,
distribution or other use is prohibited.  If you received this e-mail in
error, please notify the sender, permanently delete it, and destroy any
printout.

Thank you.

------------------------------------------------
