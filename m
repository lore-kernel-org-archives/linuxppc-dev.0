Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net
	[151.189.21.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7234DDDE24
	for <linuxppc-dev@ozlabs.org>; Sat, 19 May 2007 06:07:50 +1000 (EST)
In-Reply-To: <20070518171555.543f9bdc@hyperion.delvare>
References: <20070517143846.GC29795@ld0162-tx32.am.freescale.net>
	<FB8DD3C1-A095-4ABB-9E74-7EC66A43D983@kernel.crashing.org>
	<464C800C.20400@freescale.com>
	<FFBD3A3A-ADBE-4DC8-A1A1-4163367244D5@kernel.crashing.org>
	<464C871C.4090300@freescale.com>
	<5B363A90-5528-4441-BBF9-9C6D8833D938@kernel.crashing.org>
	<20070518171555.543f9bdc@hyperion.delvare>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <a52c1269957b64d6958bb0fd29305552@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [i2c] [PATCH 3/5] powerpc: Document device nodes for I2C devices.
Date: Fri, 18 May 2007 22:07:38 +0200
To: Jean Delvare <khali@linux-fr.org>
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> The only support we have for i2c controllers is to support one
>> specific i2c controller from Freescale.
>>
>> If you aren't going to provide a complete solution why are you
>> prosing one?  I'm tired of this put stuff in the device tree but only
>> as much as I need to do my particular thing.
>
> This is exactly how free software development works. If people were
> only proposing complete solutions, Linux would not even exist. Things
> happen exactly because people write what they need and contribute what
> they wrote. If you think it's not enough for your own needs (present or
> future), then _you_ get to do the extra work.

You propose a generic device tree binding.  This is
a public API/ABI so it is important that it is future-
proofed as far as possible/sane/whatever.  If you're
asked how a not at all uncommon situation should be
expressed using that binding, and you cannot / will
not give an answer, that is basically equivalent to
withdrawing your proposed binding.

If you cannot get yourself to think about the general
situation, please don't try to draft generic bindings,
but restrict yourself to something board specific or
with that scope at least.  And hope no one else takes
interest in that board or they'll happily NAK your
patches.


Segher
