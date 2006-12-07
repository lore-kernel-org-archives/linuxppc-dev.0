Return-Path: <galak@kernel.crashing.org>
In-Reply-To: <BFEE19E1D0DBF84698D76276388DCB843F2251@gbrwgceumf01.eu.xerox.net>
References: <BFEE19E1D0DBF84698D76276388DCB843F2251@gbrwgceumf01.eu.xerox.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5480D0D0-2F38-4BF1-B018-78E25D97F7B6@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Power management for ppc 85xx
Date: Thu, 7 Dec 2006 09:56:45 -0600
To: Marta Chamorro <Marta.Chamorro@xerox.com>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 7, 2006, at 9:53 AM, Chamorro, Marta wrote:

> Hi again,
>
> Glad I managed to make sense. I checked the hardware spec on the board
> and it looks like we're using everything, apart from the SEC and maybe
> the stand-alone I2C (I think we're just using the one within the CMP).
> By the way, I made a mistake and the actual processor on the board is
> the cut-down 8541, not the 8555. My apologies for that.
>
> This morning I added some printks and confirmed that there is no code
> behind pm_ops, so my question remains: is there some code out there  
> that
> I can use? (hope so, otherwise I'm doomed...)

I'm sorry to say you're doomed.  I don't believe anyone's spent any  
time trying to do pwr mgmt on 85xx.

- k

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: 06 December 2006 22:53
> To: Chamorro, Marta
> Cc: linuxppc-dev@ozlabs.org; linuxppc-embedded@ozlabs.org
> Subject: Re: Power management for ppc 85xx
>
>
> On Dec 6, 2006, at 4:27 PM, Chamorro, Marta wrote:
>
>> Hi Kumar, thanks for the reply.
>>
>> I am not sure I fully understand your question, but here's an
>> attempt of
>> an answer :)
>>
>> What I want to do is:
>>
>> First stage - Get the processor on doze mode (core halted, but
>> responds
>> to interrupts)
>> Second stage - Once I understand how to do that, using all the right
>> interfaces and so on, get other devices (mainly image processing
>> ASICS)
>> to stop clocks.
>>
>> Does that answer your question? Can you help? Do you know where to
>> find
>> the code that deals with power management for the ppc 8555?
>
> It does, what periphs are you using on the 8555 itself?
>
> - k
>
>
>
