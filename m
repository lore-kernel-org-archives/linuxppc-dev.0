Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id E7D9FDDE4A
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Apr 2007 00:44:19 +1000 (EST)
In-Reply-To: <20070405085057.GC9910@localhost.localdomain>
References: <20070404110916.GA9910@localhost.localdomain>
	<a84b0389cf9e6730da79750b1afc1973@bga.com>
	<20070405085057.GC9910@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <030212e9acd638e71b2f50aa39fb90ed@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: SPI devices and OF
Date: Thu, 5 Apr 2007 09:44:13 -0500
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 5, 2007, at 3:50 AM, Sascha Hauer wrote:

> On Wed, Apr 04, 2007 at 10:57:28AM -0500, Milton Miller wrote:
>> On Wed Apr 4 21:09:16 EST 2007, Sascha Hauer wrote:
>>
>>> I'm currently writing a driver for the mpc5200 spi controller (the
>>> dedicated one, not the PSC ones).
...
>>> I think it will work this way but I found no way getting the
>>> platform_data for the spi devices.
>>
>> Why do you need platform_data for the devices?  I understand for
>> the master.   Actually, spi_device_info has a nice platform_info
>> pointer.
>
> For example the AT25 eeprom driver needs the page_size and some other 
> bits in
> the platform_data.

>> Looking through the code, It seems you want to use spi_new_device()
>> after calling spi_alloc_master() and spi_register_master().
>
> Yes, you're right. I mixed that up. Anyway, it was only meant as pseudo
> code to show what I'm trying to do.

ok, so what is the problem with the platform data?   You kzalloc the
data structure that the device needs, fill it in, and fill out
the pointer in the auto _info variable that gets copied by
register_new_device.

Am I missing something?

milton
