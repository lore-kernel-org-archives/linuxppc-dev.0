Return-Path: <tnt@246tNt.com>
Received: from outmx013.isp.belgacom.be (outmx013.isp.belgacom.be
	[195.238.3.64]) by ozlabs.org (Postfix) with ESMTP id 347D62BF07
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 25 Dec 2004 23:34:32 +1100 (EST)
Received: from outmx013.isp.belgacom.be (localhost [127.0.0.1])
	by outmx013.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id iBPCYLvE031974
	for <linuxppc-embedded@ozlabs.org>; Sat, 25 Dec 2004 13:34:21 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <41CD5E60.10404@246tNt.com>
Date: Sat, 25 Dec 2004 13:34:40 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: ivica@asist-traffic.com
References: <41C72733.9030300@asist-traffic.com>
In-Reply-To: <41C72733.9030300@asist-traffic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: i2c on mpc5200
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi

> I have a hardware clock (RTC) which is not yet supported in
> the linux kernel. It is RX-8025 module from EPSON and it is
> I2C bus-interface based. Before I start writing support for this
> module I would like to have I2C support working in my kernel.
> Has anybody succeeded in getting I2C supported for MPC5200
> based boards with 2.6 kernels? I'm using the one which maintains
> Sylvain Munaut. If I boot up the kernel with I2C support in it
> I don't get any initialization messages for I2C, only this one line:
> ----------------------------------------------------------------------
> eth0: Phy @ 0x0, type LXT971 (0x001378e2)                           
> mice: PS/2 mouse device common for all mice
> i2c /dev entries driver
> NET: Registered protocol family 2
> IP: routing cache hash table of 512 buckets, 4Kbytes
> -----------------------------------------------------------------------


Are you sure it doesn't work ?
On my system there are no I2C init message either, the driver is just 
not noisy ... (unless you activate all the I2C debug stuff).

I have the exact same message than you but if I activate the eeprom 
support then in
/sys/bus/i2c/devices, the lite5200 eeprom shows up and I can read it ...



Sylvain
