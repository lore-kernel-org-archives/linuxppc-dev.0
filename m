Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BEDF3DDDE3
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Oct 2008 00:44:22 +1100 (EST)
Message-Id: <FA1CDE18-3C98-4487-9D30-715324E96182@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Trent Piepho <tpiepho@freescale.com>
In-Reply-To: <Pine.LNX.4.64.0810300123500.3943@t2.domain.actdsltmp>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [v5] powerpc: gpio driver for mpc8349/8572/8610 and compatible
Date: Thu, 30 Oct 2008 08:44:08 -0500
References: <1222184138-6151-1-git-send-email-jacmet@sunsite.dk>
	<Pine.LNX.4.64.0810291718350.25957@t2.domain.actdsltmp>
	<8763najzl1.fsf@macbook.be.48ers.dk>
	<Pine.LNX.4.64.0810300123500.3943@t2.domain.actdsltmp>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 30, 2008, at 3:58 AM, Trent Piepho wrote:

> On Thu, 30 Oct 2008, Peter Korsgaard wrote:
>>>>>>> "Trent" == Trent Piepho <tpiepho@freescale.com> writes:
>> Trent> On Tue, 23 Sep 2008, Peter Korsgaard wrote:
>>>> +- compatible : "fsl,<CHIP>-gpio" followed by "fsl,mpc8349-gpio"  
>>>> for
>>>> +  83xx, "fsl,mpc8572-gpio" for 85xx and "fsl,mpc8610-gpio" for  
>>>> 86xx.
>>
>> Trent> Why have the three different compatible settings when the code
>> Trent> doesn't do anything different?
>>
>> Purely for cosmetics / ease of use - As requested by Kumar:
>>
>> http://ozlabs.org/pipermail/linuxppc-dev/2008-September/062934.html
>
> Though I see Scott didn't agree.

Yep ;)

>>>> +#define MPC8XXX_GPIO_PINS	32
>>
>> Trent> 8572 has eight GPIOs.
>>
>> Doesn't matter - It's register interface is compatible. Most real
>> world design with the other SoCs also don't have all 32 gpio pins
>> available because of pin multiplexing.
>
> Doesn't it seem flawed that 32 gpios will show up under debugfs and  
> via the
> sysfs interface, when it's known that there are only 8?
>
> Since there is an 8572 compat property, it's not like it's not  
> solvable.

seem like a patch is order

>> Trent> I wrote an MPC8572 GPIO driver back in March, and posted it
>> Trent> internally at Freescale on June 2nd.  But it was just
>> Trent> ignored...  I wonder what your secret is to get Kumar to apply
>> Trent> your patches?  It's too bad this work keeps getting
>> Trent> duplicated.
>>
>> Did you try bribing? ;) No, seriously, why didn't you post it to
>> linuxppc-dev, so the rest of the world would know about it?
>
> Well, I get totally ignored posting to an internal Freescale list,  
> it doesn't
> seem like it will be any better posting to an external list.

Trent I'm not ignoring you, its just I've got a lot of things on my  
plate.  I expect other to comment internally to FSL and wait til  
something gets posted externally to pay attention.  This way its  
hopefully been reviewed and commented by a number of people before I  
look at it.

Also, we have patchworks externally so I have an explicit todo list  
that I can track.

Don't feel bad.  I've ignored patches from others ;)

- k
