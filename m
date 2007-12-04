Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by ozlabs.org (Postfix) with ESMTP id BB8B7DDFB2
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Dec 2007 04:19:36 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so7091028wag
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 04 Dec 2007 09:19:35 -0800 (PST)
Message-ID: <9e4733910712040919v6208c5a3o1afd456c86a37589@mail.gmail.com>
Date: Tue, 4 Dec 2007 12:19:25 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Clemens Koller" <clemens.koller@anagramm.de>
Subject: Re: OT: Re: solved: Re: [rtc-linux] Re: DS1337 RTC on I2C broken.
In-Reply-To: <4755731D.4050106@anagramm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <474FEE20.6070606@anagramm.de> <47542A50.1030208@anagramm.de>
	<47543351.2080904@freescale.com> <47543FAD.7040504@anagramm.de>
	<475445DF.6080202@freescale.com> <47545A81.90804@anagramm.de>
	<20071203204652.GB4850@loki.buserror.net>
	<47553D31.4080306@anagramm.de>
	<20071204130841.GA5765@loki.buserror.net>
	<4755731D.4050106@anagramm.de>
Cc: Alessandro Zummo <alessandro.zummo@towertech.it>,
	rtc-linux@googlegroups.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 12/4/07, Clemens Koller <clemens.koller@anagramm.de> wrote:
> That was discussed already in detail in several threads and there
> were already decisions made that the DT went into the kernel - no problem
> with that.
> I just don't see that it 'really does help' in it's current state if
> things are broken in a way they are hard to fix for non DT-familiar
> developers, almost impossible to fix for users which just need to
> compile their own kernel to achieve their project goal.
>
> Well... let's take it easy. I'll dig into the pcf8563 code now.

Most of this is addressed in the patch series starting with this message:
http://ozlabs.org/pipermail/linuxppc-dev/2007-December/047382.html

The pcf8563 driver is converted to the new format and is modified to
pick up it's address from the device tree.

This patch series is being held waiting for an ok on the low level
changes to the i2c subsystem. Hopefully it will go into 2.6.25


-- 
Jon Smirl
jonsmirl@gmail.com
