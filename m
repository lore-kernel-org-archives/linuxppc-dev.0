Return-Path: <laurent.pinchart@cse-semaphore.com>
Received: from mailgate101.isp.belgacom.be (mailrelay101.isp.belgacom.be
	[195.238.6.82]) by ozlabs.org (Postfix) with ESMTP id 58887DDEE0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Jul 2007 00:57:56 +1000 (EST)
From: Laurent Pinchart <laurent.pinchart@cse-semaphore.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] [POWERPC] Move generic MPC82xx functions out of
	ADS-specific
Date: Thu, 12 Jul 2007 16:57:50 +0200
References: <200707101312.46052.laurent.pinchart@technotrade.biz>
	<200707110928.55339.laurent.pinchart@technotrade.biz>
	<4694F66D.2010907@freescale.com>
In-Reply-To: <4694F66D.2010907@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707121657.51214.laurent.pinchart@cse-semaphore.com>
Cc: Vitaly Bordug <vbordug@ru.mvista.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Scott,

On Wednesday 11 July 2007 17:25, Scott Wood wrote:
> Laurent Pinchart wrote:
> > On Tuesday 10 July 2007 20:05, Scott Wood wrote:
> >>Why are you also moving mpc82xx_ads_show_cpuinfo() to the board file?
> >>It's not really ADS-specific; it should just be renamed.
> >
> > For the MPC82xx ADS boards, mpc82xx_ads_show_cpuinfo() prints
> >
> > Vendor		: Freescale Semiconductor
> > Machine		: PQ2 ADS PowerPC
> >
> > The vendor string is hardcoded to "Freescale Semiconductor", and the
> > machine string is defined in pq2ads.h. What should show_cpuinfo() print ?
> > Should the vendor be the board vendor or the CPU vendor ? What about the
> > machine ?
>
> Ah, I missed that.  I'd just get rid of "Vendor" altogether, and include
> the vendor name in the machine name.

Is there any standard/documentation regarding what show_cpuinfo should print ? 
Should it show CPU information only, or board information as well ? What 
about the memory size, clock settings, ... ? What are the meanings 
of "vendor" and "machine" ?

-- 
Laurent Pinchart
CSE Semaphore Belgium
