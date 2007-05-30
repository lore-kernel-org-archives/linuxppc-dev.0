Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 69C72DDF8F
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 23:14:12 +1000 (EST)
In-Reply-To: <1180525953.1F02B585@fk13.dngr.org>
References: <1180423456.19517.124.camel@localhost.localdomain>
	<1180524227.19517.256.camel@localhost.localdomain>
	<1180525953.1F02B585@fk13.dngr.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <c398e383b63208c6b261d61d0f81d9aa@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Saving to 32 bits of GPRs in signal context
Date: Wed, 30 May 2007 15:14:06 +0200
To: Felix Domke <tmbinc@elitedvb.net>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>  Anyway, please don't. It is *not* portable.
>> What are you talking about ? Really, I mean, I'm not sure I understand
>> what you mean :-)
> Segher stated that there is no portable way of detecting whether 64bit
> instructions are available, and said that just trying a 64bit insn (and
> catching the SIGILL if thre cpu is 32bit) is probably the most portable
> way to do so. (Or did i got *that* wrong? If so, please ignore.)

That is exactly what I said.  Note I didn't say it
is the *best* method, just the most portable one :-)

> Now my objection is that the "SIGILL"-way is not only ugly, but can be
> easily *wrong*, as there are certain possibilities (Book-E 64bit,
> non-64bit-aware OS, ...) when the CPU might not throw an exception.

All those cases would throw an exception.

> (My
> "ffmpeg with vmx"-experience shows this is a real world issue, although
> the situation is a bit different there, i agree, since vmx opcodes are
> not exclusively reserved for vmx)

Yeah nasty business.


Segher
