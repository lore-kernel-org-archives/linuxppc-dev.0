From: DavidHo@nanometrics.ca
Subject: Input driver on 2.4.18 kernel
To: linuxppc-embedded@lists.linuxppc.org
Cc: linuxconsole-dev@lists.sourceforge.net
Message-ID: <OF275AEF2A.58524FF9-ON85256DBB.0076FAF2@nanometrics.ca>
Date: Fri, 10 Oct 2003 18:11:11 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

     I have been looking into the most suitable way of implementing a
keyboard driver for our custom device.  The hardware is a 5 button keypad
that is hooked up directly to the GPIO lines on the processor.  What
confuses me the most with the 2.4.18 kernel I'm using is there are two ways
of implementing the driver.  The majority of the drivers in drivers/char
are written in the old way but there is also a partial implementation of
the new USB input subsystem that simplifies the driver code a great deal.

     Can anyone tell me if the USB input subsystem on the 2.4.18 is
suitable for a non-USB input device?   Do I need a patch before I can use
this subsystem?  The Dreamcast keyboard driver adapted its code from
usb/usbkbd.c, is this a good starting point for my keypad driver as well?
I really hope I can use the new framework since it will safe me from
writing code for the old framework and then rewriting it later when it's
removed in a future kernel.

Thanks,
David Ho
Nanometrics, Inc


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
