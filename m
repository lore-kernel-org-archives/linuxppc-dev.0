Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <20050809174717.GO3187@smtp.west.cox.net>
References: <20050809174717.GO3187@smtp.west.cox.net>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4D608D36-754B-46EA-9546-304AEFFB3F3A@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Tue, 9 Aug 2005 13:49:41 -0500
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc64-dev@ozlabs.org, Geert Uytterhoeven <geert@linux-m68k.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
Subject: Re: Merging ppc32 and ppc64
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 9, 2005, at 12:47 PM, Tom Rini wrote:

> On Tue, Aug 09, 2005 at 12:41:54PM -0500, Kumar Gala wrote:
>
>>
>> On Aug 9, 2005, at 11:21 AM, Tom Rini wrote:
>>
> [snip]
>
>>> That's not 100% true because as Segher said, prom_init.c is part of
>>> the
>>> kernel (tree, image), but is what does the translation.
>>>
>>
>> I'm not sure I follow.  I understand that prom_init.c is part of the
>> kernel in ppc64.  I'm saying that such things should NOT be part of
>> the arch/powerpc kernel going forward.  They should be handled via
>> bootwrappers.
>>
>
> That's a "cleanup" we can argue about later, but I expect some
> resistance :)

Why argue later?  Isn't part of the point of the merge to do cleanup  
between ppc32 & ppc64.  When would be the point to discuss this?

- kumar
