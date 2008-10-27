Return-Path: <neko@genesi-usa.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.27])
	by ozlabs.org (Postfix) with ESMTP id 4B2BADDDD4
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2008 02:40:10 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so1623120qwb.15
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Oct 2008 08:40:08 -0700 (PDT)
Message-ID: <4905E0DC.104@genesi-usa.com>
Date: Mon, 27 Oct 2008 10:40:12 -0500
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Matt Sealey <matt@genesi-usa.com>, Mitch Bradley <wmb@firmworks.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	devicetree-discuss list <devicetree-discuss@ozlabs.org>
Subject: Re: GPIO - marking individual pins (not) available in device tree
References: <4900ED81.3040202@genesi-usa.com> <4900F90B.80703@firmworks.com>
	<4901032F.3090805@genesi-usa.com> <49011C42.2020101@firmworks.com>
	<20081024032944.GE4267@yookeroo.seuss>
	<49014C69.8020408@firmworks.com>
	<20081024044511.GI4267@yookeroo.seuss>
	<490248C2.9020104@genesi-usa.com>
	<20081026234747.GD22339@yookeroo.seuss>
In-Reply-To: <20081026234747.GD22339@yookeroo.seuss>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



David Gibson wrote:

> Um.. I can't actually follow what you're getting at there, sorry.

Imagine in your head that you have a GPIO controller that has a
32-bit register potentially controlling 32 pins on the chip.

Imagine that rather than being able to allocate 6 GPIO pins
*right next to each other* in the register and saying that
you start at "pin" 15 and use the next 6 "pins", you have to
spread it around and use pin 1, pin 8, pin 9, pin 11, pin 15,
pin 30, to make up this peripheral.

As far as I can tell there is no way at all to specify a set of
GPIO pins which are NOT consecutive because the current GPIO
spec stops after specifying a controller bank (the 32-bit
register).

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
