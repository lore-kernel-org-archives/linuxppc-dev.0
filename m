Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 99CA8DDDEA
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Dec 2008 10:09:19 +1100 (EST)
Message-ID: <49346E24.7090002@freescale.com>
Date: Mon, 01 Dec 2008 17:07:16 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Trent Piepho <tpiepho@freescale.com>
Subject: Re: i2c-mpc clocking scheme
References: <492EB606.9020703@matrix-vision.de>
	<ed82fe3e0811270724t26d2a8e2v233143722eb8587f@mail.gmail.com>
	<492EC031.9000802@matrix-vision.de>
	<Pine.LNX.4.64.0811281255001.12483@t2.domain.actdsltmp>
	<4933FBC6.50100@freescale.com> <49343DC2.3070601@matrix-vision.de>
	<Pine.LNX.4.64.0812011347450.10176@t2.domain.actdsltmp>
	<49346497.8050701@freescale.com>
	<Pine.LNX.4.64.0812011438550.10176@t2.domain.actdsltmp>
In-Reply-To: <Pine.LNX.4.64.0812011438550.10176@t2.domain.actdsltmp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: =?UTF-8?B?QW5kcsOpIFNjaHdhcno=?= <Andre.Schwarz@matrix-vision.de>,
	Timur Tabi <timur@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Trent Piepho wrote:
> The Linux code could use current-speed to know if it should program the
> registers.  I.e., if current-speed is present and non-zero, then leave the
> frequency registers alone.  Otherwise u-boot or whatever might not have
> programmed the I2C controller and the driver can do what it's doing now.

I suppose.  I was thinking that Linux could just check to see whether 
the current divider value appears to be valid, but it seems that all 
values including zero can be valid. :-(

>> When does the guest really care what the specific i2c bus frequency is, if 
>> it's not going to change it?
> 
> I don't know of a real reason.  Maybe an I2C device where the clock speed
> makes a difference?  Maximum polling rate or something?  Is there reason
> the CPU clock and the CCB frequency need to be in the device tree?

I'm fine with including it for informational purposes, it just doesn't 
seem quite as necessary.

-Scott
