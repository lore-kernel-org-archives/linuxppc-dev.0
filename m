Return-Path: <achim.machura@berghof.com>
Received: from mail140.messagelabs.com (mail140.messagelabs.com
	[85.158.137.83]) by ozlabs.org (Postfix) with SMTP id 14E9C67C5C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 31 Oct 2006 02:33:18 +1100 (EST)
From: "Achim Machura" <achim.machura@berghof.com>
To: "'David Jander'" <david.jander@protonic.nl>
Subject: AW: Xubuntu and Xenomai on the Lite5200 (IceCube)...
Date: Mon, 30 Oct 2006 16:32:58 +0100
Message-ID: <001001c6fc38$adf4d670$34f1ff0a@beint.local>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <200610301209.38103.david.jander@protonic.nl>
Cc: "Linuxppc-Embedded \(E-Mail\)" <linuxppc-embedded@ozlabs.org>
Reply-To: achim.machura@berghof.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello, David,

We have had the same problem,

after enabling pci in the kernelconfig,
usb is working.

best regards

Achim

> -----Ursprungliche Nachricht-----
> Von: linuxppc-embedded-bounces+machura=berghof.com@ozlabs.org
> [mailto:linuxppc-embedded-bounces+machura=berghof.com@ozlabs.org]Im
> Auftrag von David Jander
> Gesendet: Montag, 30. Oktober 2006 12:10
> An: linuxppc-embedded list
> Betreff: Xubuntu and Xenomai on the Lite5200 (IceCube)...
>
>
>
> Hi all,
>
> I got the task to help make Linux run on the IceCube, with
> support for MSCAN,
> FEC and USB. After a rather exciting jurney I managed to get
> kernel 2.6.18
> working with bestcomm DMA and FEC support backported from DENX's git
> 2.6.19-rcsomething, and Xenomai installed upon that.
> Btw, before Wolfgang Denk starts complaining why I didn't use
> his 2.4 kernel,
> it's because I wasn't smart enough to get USB working. If it
> does work,
> please tell me how, I just get errors when plugging in a USB
> device "kernel:
> usb.c: USB device not accepting new address=2 (error=-110)".
> This seems to work fine in 2.6, though.
> It was not easy, so I wrote everything down (I hope I didn't
> forget anything
> important):
>
> http://yopesblog.blogspot.com/2006/10/how-to-run-ubuntu-and-xe
nomai-on.html

If anyone wants to tell me what I did wrong (probably a lot), please tell
me.
I am posting this to the list hoping someone else will benefit from it. I
certainly would have.

Greetings,

--
David Jander
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
