Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2697B6876C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Nov 2005 08:04:05 +1100 (EST)
In-Reply-To: <20051114152024.GA29314@logos.cnet>
References: <20051114152024.GA29314@logos.cnet>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5F8A6977-E33A-4E84-B029-D1B49716DC82@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Date: Mon, 14 Nov 2005 14:45:46 -0600
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
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

It doesn't look very good since nothing appears to be attached :)

- kumar

On Nov 14, 2005, at 9:20 AM, Marcelo Tosatti wrote:

> FYI - how does it look now?
>
>
> ----- Forwarded message from Edson Seabra  
> <Edson.Seabra@cyclades.com> -----
>
> From: Edson Seabra <Edson.Seabra@cyclades.com>
> Date: Mon, 14 Nov 2005 12:11:19 -0800
> To: "marcelo.tosatti" <Marcelo.Tosatti@cyclades.com>
> Subject: Re: BDI and 85xx
>
>
> Hi, Marcelo.
>
> I re-make the changes following the Dan suggestion.
>
> Can you check if he will accept them this time ?
>
> Thanks,
> -Edson.
>
>
>
>
> (See attached file: 8xx_gdb.diff)
>
> Dan Malek <dan@embeddededge.com> wrote on 11/07/2005 09:17:46 AM:
>
>>
>> On Nov 7, 2005, at 6:24 AM, Marcelo Tosatti wrote:
>>
>>> Edson had to patch this in to get BDI to work on 85xx with 2.6.14.
>>
>> How about we just change MSR_KERNEL and MSR_USER
>> in the include file #define instead of all of this run-time code?
>> Or, change the code so it preserves DE in general, so we don't
>> need a special kernel configuration just for the BDI?
>>
>> The original reason I did the BDI_SWITCH was due to the
>> overhead of tracking user PTE switches in the context switch
>> code.  I don't like the way this has been overloaded to mean
>> "BDI general operation."  We should be able to attach a BDI2000
>> to any kernel configuration and always get kernel debugging
>> capability.  The BDI_SWITCH was to enable the extra feature
>> (with some overhead) of debugging into user applications,
>> it never should have affected any kernel debug operation.
>>
>> It's unfortunate that Book-E is such a PITA for debuggers,
>> but let's please find a better way of using these features.
>> Separate kernel configurations to enable hardware
>> debugging isn't acceptable.
>>
>> Thanks.
>>
>>    -- Dan
>>
>
>
> ----- End forwarded message -----
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
