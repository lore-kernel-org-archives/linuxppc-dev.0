Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8C7E4DDF2A
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Mar 2007 01:56:49 +1100 (EST)
In-Reply-To: <D1381E0F-9C2D-4D51-ABB6-41D2EA270EF3@kernel.crashing.org>
References: <20070302104718.GU4397@moe.telargo.com>
	<20070305100802.GV4397@moe.telargo.com>
	<45EBEFEE.9030309@246tNt.com>
	<20070305104031.GW4397@moe.telargo.com>
	<45EBF6B3.2080808@246tNt.com>
	<D1381E0F-9C2D-4D51-ABB6-41D2EA270EF3@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E4C151C7-1A69-4426-8A5A-A4F58832BB85@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH try3] lite5200(b) support for i2c
Date: Mon, 5 Mar 2007 08:55:50 -0600
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Sylvain Munaut <tnt@246tNt.com>, Domen Puncer <domen.puncer@telargo.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Mar 5, 2007, at 8:53 AM, Kumar Gala wrote:

>
> On Mar 5, 2007, at 4:53 AM, Sylvain Munaut wrote:
>
>> Domen Puncer wrote:
>>> Add fsl-i2c to mpc5200 i2c node in device tree, and enable FSL_SOC.
>>>
>>> Tested to work with built-in eeprom on lite5200b.
>>>
>>>
>>> Signed-off-by: Domen Puncer <domen.puncer@telargo.com>
>>>
>> Acked-by: Sylvain Munaut <tnt@246tNt.com>
>>
>>
>> I'll make sure this is included in my next merge batch to Paul.
>
> Driver patches should go via the driver subsystem maintainers and not
> Paul.

Sorry, ignore me.  I was looking at Domen's initial patch which  
touched drivers/i2c/busses/i2c-mpc.c

- k
