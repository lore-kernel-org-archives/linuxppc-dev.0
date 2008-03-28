Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1E357DE099
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2008 04:11:20 +1100 (EST)
Message-ID: <47ED26BE.2080507@freescale.com>
Date: Fri, 28 Mar 2008 12:11:26 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCHv2 2/3] ep8248e: Reference SMC parameter RAM base in the
	device tree.
References: <200803261217.46671.laurentp@cse-semaphore.com>
	<200803271010.33825.laurentp@cse-semaphore.com>
	<20080327153952.GC18728@ld0162-tx32.am.freescale.net>
	<200803281726.47566.laurentp@cse-semaphore.com>
In-Reply-To: <200803281726.47566.laurentp@cse-semaphore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Laurent Pinchart wrote:
> Locating the end of the muram isn't as straightforward as it could be. As the 
> current code already uses the beginning of the muram to store the BDs and 
> data buffers, should I really bother locating the end or can I store the SMC 
> parameter ram at the beginning as well ?

Maybe, but the end would be safer.  What's the problem with finding the 
end?  Even the end of the first reg resource would be OK.

> If I'm not mistaken, once the SMC parameter ram gets relocated to the 
> beginning/end of the muram, the boot loader preallocated space can be 
> reclaimed and can be added to the muram in the device tree like I did in my 
> previous patch. Is that correct ?

Yes.

-Scott
