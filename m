Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EC064DDE0E
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 21:03:25 +1000 (EST)
Message-ID: <46FA3CDD.2070409@genesi-usa.com>
Date: Wed, 26 Sep 2007 12:05:01 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] add Altivec/VMX state to coredumps
References: <46F88896.50706@au1.ibm.com>	
	<E4CA12E1-888D-4A8B-B687-02F9D2850E1F@kernel.crashing.org>	
	<46F94CBA.2060901@genesi-usa.com>
	<1190758712.23457.0.camel@localhost.localdomain>
In-Reply-To: <1190758712.23457.0.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Benjamin Herrenschmidt wrote:
> On Tue, 2007-09-25 at 19:00 +0100, Matt Sealey wrote:
>> Kumar Gala wrote:
>>> I'm wondering how we distinguish a core dump w/altivec state vs one  
>>> with SPE state.
>> Sheer number of registers saved?
>>
>> Why not put the PVR in core dumps that'd make it all easier..
> 
> PVR wouldn't be very useful...  What if you have altivec disabled ? Also
> that would mean your gdb has to know about all new processors...

Is that such a big deal? :D

Hypothetically it would be impossible to determine if you were running
on a G5 with the FPU and AltiVec turned off or an e500 core with SPE,
given the data saved. Is that a misfeature of GDB that we even have to
worry about this, or some noble plus point of a unified ISA? You decide :)

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
