Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9D2D567A67
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Mar 2005 03:12:22 +1100 (EST)
In-Reply-To: <20050323102501.GF7846@logos.cnet>
References: <28F2CE72-0BF0-11D9-97DC-003065F9B7DC@embeddededge.com>
	<20050210150437.GA19134@logos.cnet>
	<c5f8c158f9254cbb0a8e085cf0fda8de@embeddededge.com>
	<20050210170658.GA20153@logos.cnet>
	<20050210170859.GB20153@logos.cnet> <423F4071.1000001@mrv.com>
	<20050322130426.GE2498@logos.cnet>
	<f4f476b5e54e9f005dd28082bd5f16fe@embeddededge.com>
	<20050322175815.GB7846@logos.cnet>
	<ab78e7b7625e4293bf29fded17f589c2@embeddededge.com>
	<20050323102501.GF7846@logos.cnet>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f8d4fefc4fc282e699ee279e92c3c2ef@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Wed, 23 Mar 2005 11:12:11 -0500
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
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


On Mar 23, 2005, at 5:25 AM, Marcelo Tosatti wrote:

> You misunderstood: get_mmu_context() _wont_ be called if the mm 
> structures
> are the same.

I understood.  At most, get_mmu_context() will only do a 'tlbia'
instruction, I didn't see your reason for thinking this would have
an effect on the tlbie usage.

>> Well, that's interesting.  It's likely to only happen on an 860 
>> variant
>> that
>> has the large TLB.
>
> For what reasoning?

My initial debugging seemed to indicate a stale TLB entry.  With
the larger TLB this is more likely to happen.  The bug was never
seen on the 823/850 with smaller TLBs.

I have a new 8xx board now, so I'll have to start working on these
issues as well.

Thanks.


	-- Dan
