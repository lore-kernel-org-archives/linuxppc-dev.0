Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5F372DDEDB
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Jan 2008 09:18:32 +1100 (EST)
Message-ID: <478FD442.8060902@freescale.com>
Date: Thu, 17 Jan 2008 16:18:42 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Bruce_Leonard@selinc.com
Subject: Re: Endian problem when accessing internel regs on 8347
References: <OF828247BA.CFEBC1F6-ON882573D3.00661B7D-882573D3.00666F62@selinc.com>
In-Reply-To: <OF828247BA.CFEBC1F6-ON882573D3.00661B7D-882573D3.00666F62@selinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Bruce_Leonard@selinc.com wrote:
>>> __asm__ __volatile__("lwz%U1%X1 %0,%1; twi 0,%0,0; isync" : "=r" (ret) 
> : 
>>> "m" (*addr));
>> They allow the compiler to use update and/or index mode for the memory 
>> operand.
> 
> Well that makes sense, U for update and X for index, but I'm not sure 
> they're applicable to this particular instruction and I'm not sure that 
> the memory operand makes sense for PowerPC.

Why not?

> However, before I post 
> anything that makes me look like I've got hoof-n-mouth disease I'm going 
> to do some more digging.  Is the GCC manual the only "official" 
> documentation on this (I've found a couple of web sites but none of them 
> gun.org)

I believe so... other than the sources, of course. :-)

-Scott
