Return-Path: <michaelzwrk@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.232])
	by ozlabs.org (Postfix) with ESMTP id 38454DDEC0
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  6 Apr 2007 01:08:34 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id i31so520746wxd
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 05 Apr 2007 08:08:33 -0700 (PDT)
Message-ID: <1ea6be8e0704050808l20b80da7t3b8fad2ddc4f4948@mail.gmail.com>
Date: Thu, 5 Apr 2007 17:08:32 +0200
From: Michael <michaelzwrk@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Looking for a driver for Compact Flash access
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
I'm have an embedded system using Compact Flash device.
I'm trying to figure out what is the right driver to access the CF.

The HW configuration is as following:
The CF is connected directly to MPC8541 CPU (PowerQUICC III,
Freescale), via local bus.
It is connected in Memory Mode, with 8-bit interface.

The questions I have:
1. What is the appropriate driver? Since memory mode is
PCMCIA-compatible PC Card ATA, I assume it is ide-cs. Is it right?

2. The card doesn't issue interrupts in this mode. I got the
impression the IDE driver relies on interrupts. Does it make it
unusable for accessing a CF in Memory Mode?


Most grateful for your help,
                                            Michael
