Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <200509090008.39692.pantelis.antoniou@gmail.com>
References: <200509090008.39692.pantelis.antoniou@gmail.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D8DEC759-EAB9-457F-AF7B-A10D6593B27A@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 8 Sep 2005 16:20:17 -0500
To: <pantelis.antoniou@gmail.com>
Cc: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
	linuxppc-embedded@ozlabs.org
Subject: Re: cpu features testing 32 vs 64 bit
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 8, 2005, at 4:08 PM, Pantelis Antoniou wrote:

> On Friday 09 September 2005 00:02, Becky Bruce wrote:
>
>> So,
>>
>> in include/asm-ppc64/cacheflush.h is the following:
>>
>> static inline void flush_icache_range(unsigned long start, unsigned
>> long stop)
>> {
>>          if (!cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
>>                  __flush_icache_range(start, stop);
>> }
>>
>> On the 32-bit side, we don't need the feature test -
>> CPU_FTR_COHERENT_CACHE is only defined in 64-bit land, and has  
>> bits set
>> in the upper 32.
>>
>>
>
> Oh yes we need it. 8xx is non coherent.

I think she lost the I in ICACHE... its a power5 only feature at this  
point.

- kumar
