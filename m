Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5A33E67A8A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Mar 2005 08:55:15 +1100 (EST)
In-Reply-To: <20050322130426.GE2498@logos.cnet>
References: <EA78B62757AF1E4799828249310AC4CA071D281F@stca206a.bus.sc.rolm.com>
	<28F2CE72-0BF0-11D9-97DC-003065F9B7DC@embeddededge.com>
	<20050210150437.GA19134@logos.cnet>
	<c5f8c158f9254cbb0a8e085cf0fda8de@embeddededge.com>
	<20050210170658.GA20153@logos.cnet>
	<20050210170859.GB20153@logos.cnet> <423F4071.1000001@mrv.com>
	<20050322130426.GE2498@logos.cnet>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f4f476b5e54e9f005dd28082bd5f16fe@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Tue, 22 Mar 2005 15:57:08 -0500
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


On Mar 22, 2005, at 8:04 AM, Marcelo Tosatti wrote:

> I'm quite puzzled. Why v2.6 calls the "tlbie" instruction 100-or-so
> less times than v2.4 ?

Oh my ...  I'm more worried about the high number of TLB misses
in 2.6 compared to 2.4.  That's really bad.  How did you instrument
the tlbie measurement?  It could be that 2.4 used lots more 'tlbia'
which were replaced by tlbie in 2.6.

Thanks.


	-- Dan
