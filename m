Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Reply-To: <zjzhou@newrocktech.com>
From: "John Zhou" <zjzhou@newrocktech.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: reboot by software
Date: Tue, 16 Dec 2003 17:38:46 +0800
Message-ID: <000101c3c3b8$68333110$b702a8c0@newrock2>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <3FDEC771.7030907@imc-berlin.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello!

I have a linux running on my mpc8260 board( power on reset at 0xfff00100, I use 32 bit flash, and directly maping 0xF0000000 ~ 0xFFFFFFF in kernel).

Now, I want to reboot system by software. But, when I jump to 0xfff00100 in kernel mode, it's going dead. Can anybody help me?

Thanks.

John

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
