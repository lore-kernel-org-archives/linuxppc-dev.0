Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id 786F967A7D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Mar 2005 01:14:30 +1100 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id j2OEIGFu009677
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Mar 2005 16:18:17 +0200 (EET)
Message-ID: <4242C919.5050303@intracom.gr>
Date: Thu, 24 Mar 2005 16:05:13 +0200
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
References: <c5f8c158f9254cbb0a8e085cf0fda8de@embeddededge.com>	<20050210170658.GA20153@logos.cnet>	<20050210170859.GB20153@logos.cnet>
	<423F4071.1000001@mrv.com>	<20050322130426.GE2498@logos.cnet>	<f4f476b5e54e9f005dd28082bd5f16fe@embeddededge.com>	<20050322175815.GB7846@logos.cnet>	<ab78e7b7625e4293bf29fded17f589c2@embeddededge.com>	<20050323102501.GF7846@logos.cnet>	<f8d4fefc4fc282e699ee279e92c3c2ef@embeddededge.com>
	<20050323160544.GB5305@logos.cnet>
In-Reply-To: <20050323160544.GB5305@logos.cnet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "Smith, Craig" <craig.d.smith@siemens.com>, paulus@samba.org,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Linux 2.6.x on 8xx status
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
> On Wed, Mar 23, 2005 at 11:12:11AM -0500, Dan Malek wrote:
> 
>>On Mar 23, 2005, at 5:25 AM, Marcelo Tosatti wrote:
>>
>>
>>>You misunderstood: get_mmu_context() _wont_ be called if the mm 
>>>structures
>>>are the same.
>>
>>I understood.  At most, get_mmu_context() will only do a 'tlbia'
>>instruction, I didn't see your reason for thinking this would have
>>an effect on the tlbie usage.
> 
> 
> OK. That is not a good reason, indeed.
> 
> 
>>>>Well, that's interesting.  It's likely to only happen on an 860 
>>>>variant
>>>>that
>>>>has the large TLB.
>>>
>>>For what reasoning?
>>
>>My initial debugging seemed to indicate a stale TLB entry.  With
>>the larger TLB this is more likely to happen.  The bug was never
>>seen on the 823/850 with smaller TLBs.
>>
>>I have a new 8xx board now, so I'll have to start working on these
>>issues as well.
> 
> 
> OK!

I've just managed to get 2.6.12-rc1 running on my 870 based board
and the tlb invalidate is still needed.

Investigating...

Regards

Pantelis
