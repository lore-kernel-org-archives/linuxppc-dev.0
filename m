Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net
	[151.189.21.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 42423DDE22
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Feb 2007 04:52:57 +1100 (EST)
In-Reply-To: <1172250409.1902.4.camel@localhost.localdomain>
References: <45D7A914.4040000@am.sony.com>
	<20070220022538.GH17818@localhost.localdomain>
	<45DB0448.9080301@am.sony.com> <45DB1759.2010302@am.sony.com>
	<fc45fc62b1568ccaedb712d3a6eb5ca0@kernel.crashing.org>
	<1172250409.1902.4.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <38d58173c87668b983e8b5173e4ab3e5@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC 3/3] zImage: Exception vector support
Date: Fri, 23 Feb 2007 18:52:51 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> If this is an ELF file, you can put the exception vectors in a
>> separate segment.  Or if you don't need the entry point to
>> be in the low region, (and you don't need that unless your
>> boot loader ignores the entry point in the ELF header), you can
>> copy the vectors in at startup and have no code linked at 0 at
>> all.
>
> No you cant. When flashed in ROM, the HV expands the bootloader binary
> at 0 and jumps to 0x100

Yeah, I said "if this is an ELF file", and that's not the
case unfortunately.


Segher
