Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net
	[151.189.21.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 28176DDE3A
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2007 20:37:18 +1000 (EST)
In-Reply-To: <1180947682.10048.23.camel@localhost.localdomain>
References: <1180406209.8139.13.camel@localhost.localdomain>
	<BA0C2035-FCAD-4B34-A622-F79432079F10@kernel.crashing.org>
	<1180492466.12577.6.camel@localhost.localdomain>
	<A78C881D-26C3-4545-85CA-80C05085C039@kernel.crashing.org>
	<1180503967.12577.20.camel@localhost.localdomain>
	<19325B38-202C-4837-9BE8-0ACA482F2605@kernel.crashing.org>
	<976AFF56-7590-46B9-ADCA-4FA6673D4C9B@kernel.crashing.org>
	<1180945726.10048.0.camel@localhost.localdomain>
	<dc4e7ef8f03da79b9322f21b8b82c6d9@kernel.crashing.org>
	<1180947682.10048.23.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <c6f611e5eaff31a78979752ecd49e5f2@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v2]: Fix e500 v2 core reboot bug
Date: Mon, 4 Jun 2007 12:37:05 +0200
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>> guts@e00000 {

>> If "guts" is some kind of official name (i.e., the
>> block is called that in the user manual), it looks
>> okay to me.
> No! It is not official name. It is provided by Kumar. It should be a
> abbr. standing for "Global Utilities" as far as my understand.

So the official name is "global utilities block"?

>> Otherwise, please change; in fact, just
>> change the name anyway (not the compatible), to
>> "shared-soc-regs" or something like that;
> I can not agree with you. "shared-soc-regs" can not describe the
> property of this kind of register.
> The official description for this set of registers:
>
> "The global utilities block controls power management, I/O device
> enabling, power-on-reset (POR) configuration monitoring, 
> general-purpose
> I/O signal configuration, alternate function selection for multiplexed
> signals, and clock control.
>
> gub (Kumar's style?): global utilities block
> or
> global-uti-regs or global-uti (Segher's style?)
> may be better.

"global-utilities" sounds fine to me, although the
name doesn't actually say anything.  Let's avoid
abbr.s unless they are very widely known.

>>  "name"
>> should be descriptive (but terse).
>>
> Agree!
> But we should reach a agreement!

Nah, you guys just need to come up with a good name :-)
I would just call it "control" perhaps ;-)

It doesn't matter much, but "name" should be human-
readable, human-understandable, and short.  A made-up
acronym doesn't work (although I like "guts", sure --
put it in your "compatible" property ;-) )


Segher
