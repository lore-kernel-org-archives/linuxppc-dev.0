Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 59AAFB7C30
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Sep 2009 16:03:01 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9579DDDD04
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Sep 2009 16:03:00 +1000 (EST)
Message-Id: <E0C48D2F-2AFC-485D-B06F-D544B4C0E7FD@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1251870487.14675.416.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [PATCH] powerpc/fsl-booke: Use HW PTE format if CONFIG_PTE_64BIT
Date: Wed, 2 Sep 2009 01:02:53 -0500
References: <1251856122-24560-1-git-send-email-galak@kernel.crashing.org>
	<1251870487.14675.416.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 2, 2009, at 12:48 AM, Benjamin Herrenschmidt wrote:

> On Tue, 2009-09-01 at 20:48 -0500, Kumar Gala wrote:
>> Switch to using the Power ISA defined PTE format when we have a 64- 
>> bit
>> PTE.  This makes the code handling between fsl-booke and book3e-64
>> similiar for TLB faults.
>>
>> Additionally this lets use take advantage of the page size  
>> encodings and
>> full permissions that the HW PTE defines.
>>
>> Also defined _PMD_PRESENT, _PMD_PRESENT_MASK, and _PMD_BAD since the
>> 32-bit ppc arch code expects them.
>
> No immediate problem with the patch, though I can't test it so I
> assume you did :-)

Yes, I tested it.

> Is this 2.6.32 material ? I'm going to stick it into my test branch
> for now regardless.

Yes this is .32 material

- k
