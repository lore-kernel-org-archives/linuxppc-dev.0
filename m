Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <B164B53F5BD6D511888D009027732E1A0249CB@ntserver.act.domain>
From: Rudolf Ladyzhenskii <rudolf.ladyzhenskii@act-aus.net>
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: autoboot with initial RAM disk
Date: Fri, 21 Dec 2001 15:44:51 +1100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, all

I am using ppcboot to start my 8260 based card. At the moment, we load Linux
kernel via tftp and then start it. Linux kernel maps its root file system
over the network. This works fine qith ppcboot autoboot feature.

Now, we want to put initial RAM disk into RAM as well as compressed kernel.
Do do that, both images have to be copied into card's memory using tftp and
them bootm command will be used with two arguments to start kernel.

To continue to use ppcboot autoboot feature we have to pass two commands as
boot command (to tftp two kernels) and then issue bootm command with two
arguments. Is there any way of doing it without altering the ppcboot source
code?

Thanks,
/************************/
Rudolf Ladyzhenskii
DSP Engineer
Advanced Communication Technologies
ph.  +61 3 8080 8215
fax. +61 3 9672 8800
Level 9, 190 Queen Street,
Melbourne, 3000
Australia
/***********************/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
