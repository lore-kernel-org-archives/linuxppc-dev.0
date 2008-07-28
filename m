Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <9e4733910807271500l23fd2b12n940197474a5291df@mail.gmail.com>
References: <20080714175437.GA5230@polina.dev.rtsoft.ru>
	<20080727001119.GB12191@secretlab.ca>
	<9e4733910807262205l2db8d662u9dd2e517282686f8@mail.gmail.com>
	<fa686aa40807262235l47bff0bfi15d86a6e171d6775@mail.gmail.com>
	<9e4733910807270721h5777bb80u9f3d25413a62883c@mail.gmail.com>
	<77a246d166f3eafb4d6a5d899ff86945@kernel.crashing.org>
	<9e4733910807271500l23fd2b12n940197474a5291df@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <043095cdcd52bb7af5cf4373b249b302@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] of: i2c: improve last resort compatible entry selection
Date: Mon, 28 Jul 2008 09:47:21 +0200
To: "Jon Smirl" <jonsmirl@gmail.com>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>  A reasonable "compatible" value would be something like
>> "serial-eeprom-24c32".
>>  You can go a little bit more generic than that, if you write up in
>>  your binding how the driver should figure out the device size and
>>  the protocol used.
>
> Matching on "serial-eeprom-24c32" requires me to convince the at24
> authors to add that string as an alias binding for their driver.

No, it requires the IIC subsystem to get fixed and not use OF
"compatible" values as module alias names.

> How
> about "serial-eeprom,24c32" or "generic,24x32"?

Neither "serial-eeprom" nor "generic" is the name of a vendor, so
no.  The comma has a well-defined meaning.  Why would a comma be
easier than a dash for your device matching code, anyway?


Segher
