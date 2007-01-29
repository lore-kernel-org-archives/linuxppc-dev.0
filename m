Return-Path: <BillF@optiscan.com>
Received: from mail.optiscan.com (mail.optiscan.com [203.26.112.1])
	by ozlabs.org (Postfix) with ESMTP id 0115EDE092
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 29 Jan 2007 18:37:12 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Boot w/ VGA console - PCI nvidia
Date: Mon, 29 Jan 2007 18:20:11 +1100
Message-ID: <34E73CC1202BF246B7DE3463BEBC0689303D81@postie.optiscan.com>
In-Reply-To: <000001c741af$310ff4c0$6405a8c0@absolut>
References: <000001c741af$310ff4c0$6405a8c0@absolut>
From: "Bill Farrow" <BillF@optiscan.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Russell McGuire wrote:
> Next I have plugged in a nVidia GeForce FX5200 PCI card,
> and compiled in the nvidafb driver.
>
> I can see clearly the PCI card is being detected and the
> nvidiafb driver is being registerd, it can even detect
> the monitor I have connected.
>
> However, when I enabled the kernel to use the framer
> buffer console, by compiling in that feature, it just=20
> 'seems' to hang after the console_init call.

Hi Russ,
I got to the same point last year with an ATI PCI card on a MPC8560
system. At this stage, I believe that to get the card displaying
graphics you will need to run the card's Video BIOS to initialise the
card correctly.

I'm guessing that you are running a PPC cpu :-) and that the FX5200 is a
consumer x86 graphics card.  If so, the Video BIOS will be x86
instructions and you will need to run it with an emulator.

A company called SciTech is maintaining an x86emu project for doing
this:
  http://www.scitechsoft.com/products/dev/x86_emulator.html

I believe that Xorg also has a x86emu module, so I was going to see if I
could get an Xorg installation going and let it do it's magic.

For us, getting Xorg running would prove the graphics capability of our
platform and we can start writing a GUI.  Then it would be just a matter
of getting uBoot to display something during boot to keep the customers
happy...


Bill
