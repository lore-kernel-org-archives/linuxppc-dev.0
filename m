Message-Id: <200306300306.WAA17705@lists.linuxppc.org>
From: "zhu jiangbo" <zhujb@szonline.net>
To: "steven.scholz@imc-berlin.de" <steven.scholz@imc-berlin.de>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: MPC8xx EXT_DIRECT IDE 
Mime-Version: 1.0
Content-Type: text/plain
Date: Mon, 30 Jun 2003 11:05:56 +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Steven,
 I have read the mail listed below on the "lists.linuxppc.org" website.
It looks like you are the right expert who can help me solving my
problem.
 The embedded linux can't detect my SANDISK CF card. I choosed the
EXT_DIRECT mode (CF's TRUE IDE mode), but now I am not sure if my design
is right. Would you please send me the schematics and documents about
MPC8xx IDE?
	Thanks very much!
B.R.

　　　　　　　　Jacob Zhu
　　　　　　　　zhujb@szonline.net
　　　　　　　　　　2003-06-30


>Subject:  Re: MPC8xx IDE
>From:  Steven Scholz <steven.scholz@imc-berlin.de>
>Date:  Wed, 24 Oct 2001 14:02:33 +0200

>> While trying to find an easy way to add non-volatile storage on a
>> custion MPC860 board, I noticed that there was some support for IDE on
>> the PCMCIA interface in the Linux kernel.

>There are actually at least three ways for connecting an IDE HDD. See
>ide-m8xx.c:

>---
>8xx_PCCARD uses the 8xx internal PCMCIA interface in combination
>with a PC Card (e.g. ARGOSY portable Hard Disk Adapter),
>ATA PC Card HDDs or ATA PC Flash Cards (example: TQM8xxL
>systems)

>8xx_DIRECT is used for directly connected IDE devices using the 8xx
>internal PCMCIA interface (example: IVMS8 systems)

>EXT_DIRECT is used for IDE devices directly connected to the 8xx
>bus using some glue logic, but _not_ the 8xx internal
>PCMCIA interface (example: IDIF860 systems)
>---

>I am probably the only one using EXT_DIRECT. ;-)

>Drop me a line if you need schematics.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
