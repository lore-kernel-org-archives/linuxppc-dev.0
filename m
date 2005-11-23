Return-Path: <absoluthunter@comcast.net>
Received: from sccrmhc11.comcast.net (sccrmhc11.comcast.net [63.240.77.81])
	by ozlabs.org (Postfix) with ESMTP id 275D3687F3
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Nov 2005 01:44:20 +1100 (EST)
From: "Absolut Hunter" <absoluthunter@comcast.net>
To: <linuxppc-embedded@ozlabs.org>
Date: Wed, 23 Nov 2005 06:44:09 -0800
Message-ID: <000901c5f03c$5d4e8c60$6405a8c0@absolut>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: USB Keyboard Support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Everyone,

I recently got the USB device up and working under DENX Linux 2.4.25 with a
MPC8280.

We are using a Sm501 video chip and also have that working now, I was hoping
to get the USB Keyboard system and running so I could totally run the system
without having to use the serial port as the stdin/stdout anymore.

However, I am having trouble getting any USB keyboard input to be recognized
as the stdin or anything really.

I have verified that the kernel sees the keyboard and associates the correct
HID driver, and keyboard driver with it.  Also I have added the
/dev/input/input0-3 files and have verified that they are receiving garbage
when keys are pressed. i.e. via 'cat input0' and dumping the input to the
console.

Anyone know what else is required in order to setup the USB keyboard as the
input device when using a VGA console?

Thanks,

-Russ
