Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0E7FC687EB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Nov 2005 03:04:43 +1100 (EST)
In-Reply-To: <20051123091107.GA3482@logos.cnet>
References: <437B2051.5030408@ru.mvista.com> <20051117135810.GB9753@logos.cnet>
	<437DE07E.6080005@ru.mvista.com>
	<20051118090845.GB12765@logos.cnet>
	<17283.54950.681390.749679@cargo.ozlabs.ibm.com>
	<20051123091107.GA3482@logos.cnet>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <ACB2F36A-0A37-4EA1-9E4A-F773AD4E0D86@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Date: Wed, 23 Nov 2005 10:05:19 -0600
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
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


On Nov 23, 2005, at 3:11 AM, Marcelo Tosatti wrote:

> On Wed, Nov 23, 2005 at 01:40:38PM +1100, Paul Mackerras wrote:
>> Marcelo Tosatti writes:
>>
>>> Paul, you're OK with the following definitions on asm-ppc/io.h?
>>>
>>> +/* access ports */
>>> +#define setbits32(_addr, _v) out_be32(&(_addr), in_be32(& 
>>> (_addr)) |  (_v))
>>> +#define clrbits32(_addr, _v) out_be32(&(_addr), in_be32(& 
>>> (_addr)) & ~(_v))
>>> +
>>> +#define setbits16(_addr, _v) out_be16(&(_addr), in_be16(& 
>>> (_addr)) |  (_v))
>>> +#define clrbits16(_addr, _v) out_be16(&(_addr), in_be16(& 
>>> (_addr)) & ~(_v))
>>
>> I guess so... how many drivers need these things?
>
> Many.

Shouldn't these go into some non-arch specific location?  I hate  
making drivers only build on a give arch.

- kumar
