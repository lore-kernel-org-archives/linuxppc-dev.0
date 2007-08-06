Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20070803031349.GD6418@localhost.localdomain>
References: <20070730150648.GA5005@ru.mvista.com>
	<20070801020836.GB31391@localhost.localdomain>
	<65ff446478a9fd0a48061079d5f04f8f@kernel.crashing.org>
	<20070801050422.GI31391@localhost.localdomain>
	<20070801054751.GM31391@localhost.localdomain>
	<46B1F6D4.3070707@ru.mvista.com>
	<20070803031349.GD6418@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3831d2304a027a1790e6d3cd666c2494@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/6] PowerPC 440EPx: Sequoia DTS
Date: Mon, 6 Aug 2007 22:20:01 +0200
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

>>> +     - compatible : should contain the specific model of flash 
>>> chip(s) used
>>> +       followed by either "cfi-flash" or "jedec-flash"
>>
>>     This "compatible" prop (and the node in whole) doesn't say a
>> thing about how the flash is mapped into the CPU address space.  I
>> strongly disagree that this node provides enough info to select a
>> driver. :-/
>
> To be honest, I'm not sure that describing the mapping is really the
> job of the compatible property.  That the flash is mapped into the
> address space is kind of implicit in the way the reg interacts with
> the parents' ranges property.

Exactly.

> Can you describe some of the options for *not* direct mapped flash
> chips - I can't reasonably come up with a way of describing the
> distinction when I've never seen NOR flash other than direct mapped.

What, you've never seen SPI flash or IIC flash?  :-)

Not that these are handled by the MTD framework AFAIK.


Segher
