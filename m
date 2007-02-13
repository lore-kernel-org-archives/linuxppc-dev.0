Return-Path: <linuxppcemb@lkmail.de>
Received: from pm1.terions.de (pm1.terions.de [83.137.96.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.s-s-l.net",
	Issuer "Equifax Secure Global eBusiness CA-1" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 63B64DDF94
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Feb 2007 06:04:14 +1100 (EST)
From: "Lorenz Kolb" <linuxppcemb@lkmail.de>
To: <linuxppc-embedded@ozlabs.org>
References: <mailman.120.1171370674.21008.linuxppc-embedded@ozlabs.org>
Subject: Re: How can I boot a program from flash on ML403?
Date: Tue, 13 Feb 2007 19:57:24 +0100
Message-ID: <000001c74fa0$ce627870$10b2a8c0@lorenzulm>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <mailman.120.1171370674.21008.linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I wasted a lot of time making fitting u-boot into the 64K of BRAM, just to
see data2mem from EDK 8.1 crashing

Thus my current (dirty) solution is:

Using SREC Bootloader from Xilinx' EDK to load a U-Boot and make U-Boot load
Linux both located on flash.
Actually, it is quick and dirty, but it works fine for testing...

Greetings,

Lorenz Kolb


On Tue, 13 Feb 2007 20:17:00 +0800
yunfeizhang@sjtu.edu.cn wrote:

>hi, all:

>    I want to porting u-boot to ML403,but first I should master booting a
common app from flash first.Who can tell how to do that?Any details about
u-boot on ML403 is also prefered

>    Thanks for all your kindness!
