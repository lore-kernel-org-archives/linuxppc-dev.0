Return-Path: <nagne_hsi@naver.com>
Received: from smtp2.nm.naver.com (i61972.naver.com [211.218.150.186])
	by ozlabs.org (Postfix) with ESMTP id 57E37DDEE8
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Sep 2008 17:18:33 +1000 (EST)
From: "seokin Hong" <nagne_hsi@naver.com>
To: "'Josh Boyer'" <jwboyer@gmail.com>
References: <001301c91e90$7e0090e0$7a01b2a0$@com>
	<20080925001323.GA26152@yoda.jdub.homelinux.org>
In-Reply-To: <20080925001323.GA26152@yoda.jdub.homelinux.org>
Subject: RE: Tickless and CPU Idle framework for PPC405
Date: Thu, 25 Sep 2008 16:17:54 +0900
Message-ID: <002a01c91ede$d3fdd310$7bf97930$@com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Generic processor idle management framework 
http://ols.108.redhat.com/2007/Reprints/pallipadi-Reprint.pdf

The interface and machine independent interface is in following directory..
/drivers/cpuidle

So, I wonder that the linux kernel ported for PPC405 use this framework to
save power.
And Is the tickless feature is added to that kernel?




-----Original Message-----
From: linuxppc-embedded-bounces+nagne_hsi=naver.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+nagne_hsi=naver.com@ozlabs.org] On Behalf
Of Josh Boyer
Sent: Thursday, September 25, 2008 9:13 AM
To: seokin Hong
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Tickless and CPU Idle framework for PPC405

On Thu, Sep 25, 2008 at 06:57:09AM +0900, seokin Hong wrote:
>Hi, All
>
> 
>
>Is the tickless feature and CPU Idle framework is added in linux tree for
>PPC405?

What CPU Idle framework?

josh
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
