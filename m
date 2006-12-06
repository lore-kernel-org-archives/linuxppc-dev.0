Return-Path: <galak@kernel.crashing.org>
In-Reply-To: <BFEE19E1D0DBF84698D76276388DCB843F208C@gbrwgceumf01.eu.xerox.net>
References: <BFEE19E1D0DBF84698D76276388DCB843F208C@gbrwgceumf01.eu.xerox.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4DA05580-4BD0-41D5-B2DA-62CD42C28FD2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Power management for ppc 85xx
Date: Wed, 6 Dec 2006 16:53:20 -0600
To: "Chamorro, Marta" <Marta.Chamorro@xerox.com>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 6, 2006, at 4:27 PM, Chamorro, Marta wrote:

> Hi Kumar, thanks for the reply.
>
> I am not sure I fully understand your question, but here's an  
> attempt of
> an answer :)
>
> What I want to do is:
>
> First stage - Get the processor on doze mode (core halted, but  
> responds
> to interrupts)
> Second stage - Once I understand how to do that, using all the right
> interfaces and so on, get other devices (mainly image processing  
> ASICS)
> to stop clocks.
>
> Does that answer your question? Can you help? Do you know where to  
> find
> the code that deals with power management for the ppc 8555?

It does, what periphs are you using on the 8555 itself?

- k
