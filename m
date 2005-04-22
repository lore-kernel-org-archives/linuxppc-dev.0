Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id BC44067A64
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Apr 2005 16:31:53 +1000 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id j3M6aCWQ027665
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Apr 2005 09:36:12 +0300 (EEST)
Message-ID: <42689729.3030100@intracom.gr>
Date: Fri, 22 Apr 2005 09:18:17 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
References: <20050421183239.GJ6525@logos.cnet>
	<20050421185027.GB12442@logos.cnet>
In-Reply-To: <20050421185027.GB12442@logos.cnet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: 26-devel@cyclades.com, linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [26-devel] v2.6 performance slowdown on MPC8xx: Measuring TLB
 cache misses
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Marcelo Tosatti wrote:
> On Thu, Apr 21, 2005 at 03:32:39PM -0300, Marcelo Tosatti wrote:
> 
>>Capture session of /proc/tlbmiss with 1 second interval:
> 
> 
> Forgot to attach /proc/tlbmiss patch, here it is.
> 
> 
[snip]

> 
>  

Thanks Marcelo.

I'll try to run this on my 870 board & mail the results.

Regards

Pantelis
