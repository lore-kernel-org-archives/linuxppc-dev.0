Return-Path: <jhautbois@gmail.com>
Received: from mail-ew0-f20.google.com (mail-ew0-f20.google.com
	[209.85.219.20]) by ozlabs.org (Postfix) with ESMTP id 88E72DDEE8
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Jan 2009 05:23:30 +1100 (EST)
Received: by ewy13 with SMTP id 13so2453151ewy.9
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jan 2009 10:23:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4970CBA9.60809@freescale.com>
References: <8cad0aa0901150342s2362e53bqf9472c1dc239636c@mail.gmail.com>
	<496F318D.6010302@denx.de>
	<8cad0aa0901150510o7a8146f1m2045e252c5e1cf24@mail.gmail.com>
	<496F4760.1010007@denx.de>
	<8cad0aa0901150706u72538941rbc22655d5a8905ea@mail.gmail.com>
	<8cad0aa0901160406l3db9c025ubdcac40b4b464d23@mail.gmail.com>
	<20090116172903.GA722@ld0162-tx32.am.freescale.net>
	<8cad0aa0901160944l48bd0e99wa13f23907838376d@mail.gmail.com>
	<8cad0aa0901160953te6c7d1cg3a4df7de7da7d182@mail.gmail.com>
	<4970CBA9.60809@freescale.com>
Date: Fri, 16 Jan 2009 19:23:28 +0100
Message-ID: <8cad0aa0901161023u382e3973w917e8fb6da8b7207@mail.gmail.com>
Subject: Re: [MPC8272ADS]Cannot start my Linux Kernel
From: Jean-Michel Hautbois <jhautbois@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

2009/1/16 Scott Wood <scottwood@freescale.com>:
> Jean-Michel Hautbois wrote:
>>
>> OK, I just tried a make of my kernel (already compiled yesterday), and
>> it generated a cuImage.mpc8272ads kernel image (which it didn't do
>> yesterday).
>> I don't know why this image was generated, but I tried to reboot using
>> this one.
>
> Use uImage if you are providing a device tree from u-boot.  cuImage is for
> older u-boots that don't support this, though you could still try using it
> on a modern u-boot with a one- or two-argument bootm command to try to
> isolate the problem.
>
> -Scott
>

Well it seems to be a (very) bad idea to use ucImage, because I cannot
have my u-boot prompt after resetting my board...
My LEDs are blinking (LD4 and LD 9) and my LD20 is off (when it should be on).

I am blocked (without the prompt on my serial line !).
JM
