Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3CE00AED.B6CA7444@esteem.com>
Date: Mon, 13 May 2002 11:50:21 -0700
From: Conn Clark <clark@esteem.com>
MIME-Version: 1.0
To: Werner Armingeon <werner.armingeon@matrix-vision.de>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC5xx now with MMU
References: <OF4942DBEA.BFBB1E47-ONC1256BB8.0028BB55@intern.matrix-vision.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello Werner,

	The MGT5100 is a very interesting and attractive chip. We were(are)
interested in developing a linux system using it. Unfortunately we were
told
(as of 3 weeks ago) that we could not get it because it was only being
sold
to automobile manufacturers. The reason for this was someone paid
Motorola
to develope this chip and Motorola needed that parties permission to
release
it to everyone.

	It is strange that Motorola sells a development board with for the
chip if it is only available for a select few.

	Are you able to get the MGT5100 ? If so from who and how much does
it cost and in what quantity?

Werner Armingeon wrote:
>
> Yes, I keep an eye on the MGT5100 since its announcement. Since few days I
> even have a board from Motorola with that most interesting MCU. It's
> simply called "IceCube - MGT5100 Evaluation Board" and has all you need
> for a nice embedded Linux system on chip/board:
>
> - MGT5100 ( PPC603e core )
> - 8MB Flash, 64 MB SDRAM
> - ATA interface
> - 3.3V PCI
> - Serial Port, 2 x CAN, Ethernet 10/100, USB, I2C
> - up to 44 GPIO
>
> All controllers for the listed interfaces are integrated in the MCU. The
> "IceCube" is shipped with an evaluation copy of CodeWarrior for Windows
> :-( . No signs of Linux in the package, but a CodeWarrior shirt and a
> multi-function tool instead ;-) .
>
> I'm not very experienced regarding the Motorola integrated controllers
> what means that I can't say anything about similarities to the peripherals
> in the other PPC MCUs already supported by Linux. As usual the "MGT5100
> User Manual" says nearly nothing about this point.
>
> Are there any others interested on a MGT5100 Linux port or even working on
> it?
>


	We are interested in a linux port for this chip but only if we can
buy it and it falls within our price range. I am not sure how much we
can
contribute as none of us is experienced enough to write a device driver
yet.
We have successfully hacked others code to work with our stuff, but I am
certain that this will be more involved.


>   Werner Armingeon / werner.armingeon@matrix-vision.de
>

	If you find Motorola has changed their policy on selling this chip
please let us know as soon as possible because we are close to having to
make
a final decision for our next project soon.


	Its good to see we aren't the only ones who want this chip. Please
pester your Motorola representitive if any of you are interested as
well.


Thanks

	Conn


--

*****************************************************************
  If you live at home long enough, your parents will move out.
*****************************************************************

Conn Clark
Engineering Stooge				clark@esteem.com
Electronic Systems Technology Inc.		www.esteem.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
