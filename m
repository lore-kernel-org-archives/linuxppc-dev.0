Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4A98068750
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Nov 2005 09:50:22 +1100 (EST)
In-Reply-To: <608ff4f57a546901e9193ebbbe368053@embeddededge.com>
References: <20051114152024.GA29314@logos.cnet>
	<5F8A6977-E33A-4E84-B029-D1B49716DC82@kernel.crashing.org>
	<20051114155313.GA29411@logos.cnet>
	<608ff4f57a546901e9193ebbbe368053@embeddededge.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <475D0B8F-FF5A-44DC-9D03-7156AFE2AAB0@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Date: Mon, 14 Nov 2005 16:50:41 -0600
To: Dan Malek <dan@embeddededge.com>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [Edson.Seabra@cyclades.com: Re: BDI and 85xx]
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Nov 14, 2005, at 4:43 PM, Dan Malek wrote:

>
> On Nov 14, 2005, at 10:53 AM, Marcelo Tosatti wrote:
>
>> Doh my bad. Attached it is.
>>
>>
>> <8xx_gdb.diff>
>
> Well, this probably works for you but have you
> considered how it affects others?
>
> I'm not going to get into the -ggdb flags discussion,
> since I know we've had that in the past.  Why is
> this needed and should it be done for everyone?
>
> Your update of MSR_KERNEL will work for you,
> but won't work on anything that isn't a Book E processor.
> You can't make this a generic update to all processors.
> It will fail on everything that really wants to use the
> BDI_SWITCH configuration option as it was intended.
> The DE in Book E conflicts with BE in traditional PPC.

We should but this in asm-ppc/reg_booke.h since book-e has its own  
MSR_* defines.

> This also doesn't do anything to address my real concern,
> we shouldn't have to create a special kernel configuration
> just to attach a debugger .........

I'm not 100% sure this is even possible on some of the book-e variants.

- kumar
