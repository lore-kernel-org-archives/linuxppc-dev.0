Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <20050817153013.GO8214@smtp.west.cox.net>
References: <20050817153013.GO8214@smtp.west.cox.net>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <184D9473-D0E7-4424-A25F-60381472C10A@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 17 Aug 2005 11:16:39 -0500
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	David Woodhouse <dwmw2@infradead.org>,
	linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] Use platform device for 8250 registration
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 17, 2005, at 10:30 AM, Tom Rini wrote:

> On Wed, Aug 17, 2005 at 10:22:54AM -0500, Kumar Gala wrote:
>
>
>>> So long as you convert arch/ppc/boot/ to this as well, why not  
>>> (or at
>>> least being able to grab the infos from these structs somehow).
>>>
>>> Once everyone is on a flat tree, I don't object to killing all of  
>>> the
>>> old-style uart definitions steaming out of <asm-ppc/serial.h>.
>>>
>>
>> Tom, do have a test system that I can look at converting that you
>> would be willing to test the changes to arch/ppc/boot for me.
>>
>
> With Matt's patch, you could boot a PReP kernel (no VGA con) :)
> But if you convert LoPEC, I'll throw the kernel at it.

Does PReP use bootcode?  I thought it was OF based, but what do I know.

- kumar
