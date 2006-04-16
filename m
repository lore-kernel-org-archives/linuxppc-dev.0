Return-Path: <kernel@andred.net>
Received: from andred.net (sushi.andred.net [217.160.180.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AD4A7679FF
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 16 Apr 2006 16:55:48 +1000 (EST)
Message-ID: <4441EA6C.7010706@andred.net>
Date: Sun, 16 Apr 2006 08:55:40 +0200
From: Andre Draszik <kernel@andred.net>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: IIC troubles w/ ppc4xx (STB04)
References: <4441A0C8.8090708@andred.net>
	<20060416030944.GA20416@gate.ebshome.net>
	<4441D739.6040107@andred.net>
	<20060416055702.GB20416@gate.ebshome.net>
In-Reply-To: <20060416055702.GB20416@gate.ebshome.net>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Eugene Surovegin wrote:
> On Sun, Apr 16, 2006 at 07:33:45AM +0200, Andre Draszik wrote:
>> I see :) So if that doesn't work, what is the preferred way of testing
>> for existence of a device in a kernel module? Should I just
>> unconditionally i2c_client_register() a static struct and then
>> i2c_master_send() to see if it works?
> 
> There is no generic reliable way to detect that some i2c device exists 
> on the bus. Even if smbus_quick worked it cannot guarantee that 
> device you found is actually device you are expected - same i2c 
> address can be used by different devices.

I know, I really meant the linux side of this, i.e. if there was maybe
something I missed till now. But doesn't seem so ;)

> Frankly, I never saw this as a problem in embedded world, because 
> most of the time you have a custom built kernel for your particular 
> board or family of the boards, and you already know what devices might 
> be there, so just trying to access those devices from whatever 
> drivers and/or user-space applications you wrote is sufficient. In 
> fact, I never needed i2c "probing" in any of almost dozen different 
> embedded projects I wrote firmware/Linux board support for.

Sure, normally you know which devices are there. I am just playing
around with two boards I have here and am adding/removing parts as I
like ;) Therefore, for the moment, I wanted my driver to be as flexible
as possible, so I thought i'd use some probing and do it the preferred
way w/o hardcoding anything. At least that's what I thought the
preferred way to be...


Thanks!
Andre'
