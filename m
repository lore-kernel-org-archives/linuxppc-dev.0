Message-ID: <20011221045432.4501.qmail@kunk.jriver.com>
Subject: Re: keyspan vs benh kernel
To: linuxppc-dev@lists.linuxppc.org
Date: Thu, 20 Dec 2001 22:54:32 -0600 (CST)
From: Robert E Brose II <bob@kunk.jriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Yes, there appears to be a problem with the firware download into all
2.4.x kernels on ppc that I've tried. Identical versions work fine
for me on i386. Probably an endian bug in the keyspan driver?

Bob
---

Hello,
   Is anyone else seeing the following errors when trying to use
the Keyspan USA-28X with benh's current 2.4.17-rc1 kernel?

I find that the usb/tts/0 and usb/tts/1 devices don't appear to work
properly and am wondering if the failures on ezusb_set_reset_R9a81da3a-
and ezusb_writememory are to blame. Is anyone else seeing this?
                        Jack
(Stuff deleted)
Dec 20 10:30:36 bogus kernel: usbserial.c: ezusb_set_reset_R9a81da3a- 1 failed
Dec 20 10:30:36 bogus kernel: keyspan.c: ezusb_writememory failed for Keyspanfirmware (-110 0033 e2179001 3)
Dec 20 10:30:36 bogus kernel: usbserial.c: ezusb_set_reset_R9a81da3a- 0 failed
Dec 20 10:30:36 bogus kernel: usbserial.c: USB Serial support registered for Keyspan USA28XB - (without firmware)
Dec 20 10:30:36 bogus kernel: usbserial.c: Keyspan USA28X - (without firmware) converter detected
Dec 20 10:30:36 bogus kernel: usbserial.c: ezusb_set_reset_R9a81da3a- 1 failed
Dec 20 10:30:36 bogus kernel: keyspan.c: ezusb_writememory failed for Keyspanfirmware (-110 0033 e2179001 3)
Dec 20 10:30:36 bogus kernel: usb.c: USB disconnect on device 5
Dec 20 10:30:36 bogus kernel: usbserial.c: ezusb_set_reset_R9a81da3a- 0 failed
Dec 20 10:30:36 bogus kernel: usbserial.c: USB Serial support registered for Keyspan USA49W - (without firmware)
Dec 20 10:30:36 bogus kernel: usbserial.c: USB Serial support registered for Keyspan USA49W
Dec 20 10:30:36 bogus kernel: keyspan.c: v1.1.1:Keyspan USB to Serial Converter Driver
Dec 20 10:30:36 bogus kernel: usbdevfs: USBDEVFS_CONTROL failed dev 6 rqt 128 rq 6 len 18 ret -32
Dec 20 10:30:36 bogus last message repeated 2 times
Dec 20 10:30:36 bogus kernel: hub.c: USB new device connect on bus1/1/3, assigned device number 7
Dec 20 10:30:36 bogus kernel: usbserial.c: Keyspan USA28X/XB converter detected
Dec 20 10:30:36 bogus kernel: usbserial.c: Keyspan USA28X/XB converter now attached to ttyUSB0 (or usb/tts/0 for devfs)
Dec 20 10:30:36 bogus kernel: usbserial.c: Keyspan USA28X/XB converter now attached to ttyUSB1 (or usb/tts/1 for devfs)


-- end of forwarded message --
--
Robert E. Brose II    N0QBJ
http://www.jriver.com/~bob/
bob@kunk.jriver.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
