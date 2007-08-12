Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20070812081604.GA6458@localhost.localdomain>
References: <20070808170728.GA21118@localhost.localdomain>
	<20070808170921.GA21487@localhost.localdomain>
	<20070809030752.GB8261@localhost.localdomain>
	<af4642f6ed6a4bc167161ac73ad75350@kernel.crashing.org>
	<20070810010217.GA17370@localhost.localdomain>
	<5cad6d634a7cb6c8c37adbb15db8dfc2@kernel.crashing.org>
	<20070812081604.GA6458@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <45bcb777f652ce509b8945ed2a9f67ee@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v3 1/2] [POWERPC] MPC832x_RDB: update dts to use spi,
	register mmc_spi stub
Date: Sun, 12 Aug 2007 13:36:41 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> But, many SoCs do have a notion of device "number", which is relevant
>>> for programming other general control registers in places.  We need 
>>> to
>>> encode it somehow, and it would be good to have a consistent way of
>>> doing it.
>>
>> I'm not convinced there isn't a more direct way to represent
>> the relevant relationships.
>>
>> Either way, we don't have enough experience with this stuff
>> yet to know what works well and what doesn't (at least, I
>> don't, and I haven't seen any evidence that others do); so
>> I'd prefer to keep this in per-device bindings for now; it
>> should be there anyhow, but once we do have experience with
>> it we could do some recommendation.
>
> Well of course it will remain in the per-device bindings.  But just
> because these are in different per-device bindings doesn't mean we
> can't *try* to use consistent property names for similar things...

Sure, if those properties do exactly the same thing, identical
names are a good thing.  Until we're reasonably certain that this
is a good way to do things I'd rather people experiment a bit
instead of all cluster around a random thing that would be labeled
"de facto standard".

:-)


Segher
