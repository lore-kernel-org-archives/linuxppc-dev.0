Return-Path: <bouncefilter+linuxppc-embedded=wd=denx.de@lists.linuxppc.org>
Message-ID: <294FD9D3403A0340BDAC38E48DCEFFDCA7C1@RES-EXCH>
From: Lokesh Kumar <kumar.lokesh@wrx-us.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: memory mapped serial driver for 16554
Date: Fri, 9 Apr 2004 08:46:24 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I have a board with mpc8xx, running linux 2.4.18. It has 16554, quad uart.
> I am using serial driver from denx, and I used it successfully for other
> board which had 16550 uart, and had interrupts hooked to IRQ4 and IRQ5.
> The new board has 4 interrupts hooked on PC8,PC9,PC10 and PC11. My
> question-
>
> How do I hook the these to the serial driver? I followed the same model as
> DAB4K board to run earlier driver.
>
> Any help is appreciated.
>
> Lokesh Kumar
> Wireless Matrix USA Inc.
> 703-262-4032
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
