Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8F06C67A7E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Mar 2005 08:11:32 +1100 (EST)
Date: Wed, 23 Mar 2005 13:05:44 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20050323160544.GB5305@logos.cnet>
References: <c5f8c158f9254cbb0a8e085cf0fda8de@embeddededge.com>
	<20050210170658.GA20153@logos.cnet>
	<20050210170859.GB20153@logos.cnet> <423F4071.1000001@mrv.com>
	<20050322130426.GE2498@logos.cnet>
	<f4f476b5e54e9f005dd28082bd5f16fe@embeddededge.com>
	<20050322175815.GB7846@logos.cnet>
	<ab78e7b7625e4293bf29fded17f589c2@embeddededge.com>
	<20050323102501.GF7846@logos.cnet>
	<f8d4fefc4fc282e699ee279e92c3c2ef@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f8d4fefc4fc282e699ee279e92c3c2ef@embeddededge.com>
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

On Wed, Mar 23, 2005 at 11:12:11AM -0500, Dan Malek wrote:
> 
> On Mar 23, 2005, at 5:25 AM, Marcelo Tosatti wrote:
> 
> >You misunderstood: get_mmu_context() _wont_ be called if the mm 
> >structures
> >are the same.
> 
> I understood.  At most, get_mmu_context() will only do a 'tlbia'
> instruction, I didn't see your reason for thinking this would have
> an effect on the tlbie usage.

OK. That is not a good reason, indeed.

> >>Well, that's interesting.  It's likely to only happen on an 860 
> >>variant
> >>that
> >>has the large TLB.
> >
> >For what reasoning?
> 
> My initial debugging seemed to indicate a stale TLB entry.  With
> the larger TLB this is more likely to happen.  The bug was never
> seen on the 823/850 with smaller TLBs.
> 
> I have a new 8xx board now, so I'll have to start working on these
> issues as well.

OK!
