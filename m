Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 24B94687F1
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Nov 2005 03:14:16 +1100 (EST)
Message-ID: <43849556.2000608@ru.mvista.com>
Date: Wed, 23 Nov 2005 19:14:14 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
References: <437B2051.5030408@ru.mvista.com>
	<20051117135810.GB9753@logos.cnet>	<437DE07E.6080005@ru.mvista.com>	<20051118090845.GB12765@logos.cnet>	<17283.54950.681390.749679@cargo.ozlabs.ibm.com>	<20051123091107.GA3482@logos.cnet>
	<ACB2F36A-0A37-4EA1-9E4A-F773AD4E0D86@kernel.crashing.org>
In-Reply-To: <ACB2F36A-0A37-4EA1-9E4A-F773AD4E0D86@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] ppc32: 8xx board-specific platform stuff for fs_enet
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> 
> On Nov 23, 2005, at 3:11 AM, Marcelo Tosatti wrote:
> 
>> On Wed, Nov 23, 2005 at 01:40:38PM +1100, Paul Mackerras wrote:
>>> Marcelo Tosatti writes:
>>>
>>>> Paul, you're OK with the following definitions on asm-ppc/io.h?
>>>>
>>>> +/* access ports */
>>>> +#define setbits32(_addr, _v) out_be32(&(_addr), in_be32(&(_addr)) 
>>>> |  (_v))
>>>> +#define clrbits32(_addr, _v) out_be32(&(_addr), in_be32(&(_addr)) & 
>>>> ~(_v))
>>>> +
>>>> +#define setbits16(_addr, _v) out_be16(&(_addr), in_be16(&(_addr)) 
>>>> |  (_v))
>>>> +#define clrbits16(_addr, _v) out_be16(&(_addr), in_be16(&(_addr)) & 
>>>> ~(_v))
>>>
>>> I guess so... how many drivers need these things?
>>
>> Many.
> 
> Shouldn't these go into some non-arch specific location?  I hate making 
> drivers only build on a give arch.
> 

Hmm, what is the worth? IIRC, in_be* stuff is defined for only ppc-specific 
archs(ppc(64),ppc,powerpc).
> - kumar
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 


-- 
Sincerely,
Vitaly
