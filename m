Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 28AD5DDE2E
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Sep 2007 21:39:16 +1000 (EST)
In-Reply-To: <1188952766.3223.3.camel@localhost.localdomain>
References: <20070831200449.598781000@linux.vnet.ibm.com>
	<20070831200643.202414000@linux.vnet.ibm.com>
	<20070903010859.GD31499@localhost.localdomain>
	<1188741584.3772.7.camel@localhost.localdomain>
	<20070904074203.748030c7@weaponx.rchland.ibm.com>
	<20070905023612.GD17189@localhost.localdomain>
	<1188952766.3223.3.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <412bb2e63637100c8d47595a19f888ae@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 3/6] Walnut DTS
Date: Wed, 5 Sep 2007 13:38:16 +0200
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Hrm.. I'm still slightly uneasy though.  In my Ebony device tree, the
>> POB's ranges exists to embed the 32-bit OPB space into the 64-bit PLB
>> space by tacking on a 0x1 in bits 32:35.  In your 405gp ranges, you're
>> describing just the address range used by OPB peripherals
>> (0xef600000-0xf0000000) as residing at address 0 in OPB-space.
>>
>> Since the ranges will still generate the right physical addresses, I
>> guess it doesn't matter.  But I'm not sure it meets the principle of
>> least surprise - since I think the documentation generally talks as
>> though addresses on the 405 OPB bus are identical to addreses on the
>> PLB.
>
> I don't care either way.  If I remember correctly, this way of doing it
> came out of a discussion with Segher.

I don't think I ever said that this is a better way of doing things --
then again, I change my mind now and then.

Someone needs to write down a proposed device binding for these busses,
and then we can really discuss things ;-)


Segher
