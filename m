Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by bilbo.ozlabs.org (Postfix) with ESMTP id A9FC7B70B0
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 18 Jul 2009 23:54:46 +1000 (EST)
Message-ID: <4A61D457.2030105@ru.mvista.com>
Date: Sat, 18 Jul 2009 17:55:35 +0400
From: Valentine <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Subject: Re: Simple question about powerpc asm.
References: <4A6194D8.9090602@gmail.com> <4A61A48D.8060601@ru.mvista.com>
	<20090718125452.3760D832E416@gemini.denx.de>
In-Reply-To: <20090718125452.3760D832E416@gemini.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: HongWoo Lee <hongwoo7@gmail.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Wolfgang Denk wrote:
> Dear Valentine,
> 
> In message <4A61A48D.8060601@ru.mvista.com> you wrote:
>> PowerPC instructions are 32-bit long. So, there are only 16 bits 
>> available within the instruction for constant values. Since address can 
>> be up to 64 bits, we have to load it a piece at a time. The "@" within 
>> the assembler instruct it to give a specially-processed form of a symbol 
>> value:
>>
>> @highest -- refers to bits 48-63 of a constant
>> @higher -- refers to bits 32-47 of a constant
>> @h -- refers to bits 16-31 of a constant
>> @l -- refers to bits 0-15 of a constant
> 
> Actually these bit numbers are wrong, as bit 0 is the MSB for PowerPC
> ;-)

All right, you got me ;)
Even copy-pasting from the IBM docs, one has to double-check :)

Regards,
Val.

> 
> Best regards,
> 
> Wolfgang Denk
> 
