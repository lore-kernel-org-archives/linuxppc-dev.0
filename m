Date: Thu, 20 Dec 2001 10:48:38 -0500 (EST)
From: Jack Howarth <howarth@bromo.med.uc.edu>
Message-Id: <200112201548.KAA78174@bromo.msbb.uc.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: keyspan vs benh kernel
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,
   Is anyone else seeing the following errors when trying to use
the Keyspan USA-28X with benh's current 2.4.17-rc1 kernel?

Dec 20 10:30:36 bogus kernel: usb.c: registered new driver serial
Dec 20 10:30:36 bogus kernel: usbserial.c: USB Serial Driver core v1.4
Dec 20 10:30:36 bogus kernel: usbserial.c: USB Serial support registered for Keyspan USA18X - (without firmware)
Dec 20 10:30:36 bogus kernel: usbserial.c: USB Serial support registered for Keyspan USA19 - (without firmware)
Dec 20 10:30:36 bogus kernel: usbserial.c: USB Serial support registered for Keyspan USA19W - (without firmware)
Dec 20 10:30:36 bogus kernel: usbserial.c: USB Serial support registered for Keyspan USA28 - (without firmware)
Dec 20 10:30:36 bogus kernel: usbserial.c: USB Serial support registered for Keyspan USA28X - (without firmware)
Dec 20 10:30:36 bogus kernel: usbserial.c: Keyspan USA28X - (without firmware) converter detected
Dec 20 10:30:36 bogus kernel: usbserial.c: USB Serial support registered for Keyspan USA28XA - (without firmware)
Dec 20 10:30:36 bogus kernel: usbserial.c: Keyspan USA28X - (without firmware) converter detected
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
Dec 20 10:30:36 bogus kernel: usbserial.c: USB Serial support registered for Keyspan USA18X
Dec 20 10:30:36 bogus kernel: usbserial.c: USB Serial support registered for Keyspan USA19
Dec 20 10:30:36 bogus kernel: usbserial.c: USB Serial support registered for Keyspan USA19W
Dec 20 10:30:36 bogus kernel: usbserial.c: USB Serial support registered for Keyspan USA28
Dec 20 10:30:36 bogus kernel: usbserial.c: USB Serial support registered for Keyspan USA28X/XB
Dec 20 10:30:36 bogus kernel: usbserial.c: USB Serial support registered for Keyspan USA28XA
Dec 20 10:30:36 bogus kernel: usbserial.c: USB Serial support registered for Keyspan USA49W
Dec 20 10:30:36 bogus kernel: keyspan.c: v1.1.1:Keyspan USB to Serial Converter Driver
Dec 20 10:30:36 bogus kernel: usbdevfs: USBDEVFS_CONTROL failed dev 6 rqt 128 rq 6 len 18 ret -32
Dec 20 10:30:36 bogus last message repeated 2 times
Dec 20 10:30:36 bogus kernel: hub.c: USB new device connect on bus1/1/3, assigned device number 7
Dec 20 10:30:36 bogus kernel: usbserial.c: Keyspan USA28X/XB converter detected
Dec 20 10:30:36 bogus kernel: usbserial.c: Keyspan USA28X/XB converter now attached to ttyUSB0 (or usb/tts/0 for devfs)
Dec 20 10:30:36 bogus kernel: usbserial.c: Keyspan USA28X/XB converter now attached to ttyUSB1 (or usb/tts/1 for devfs)

I find that the usb/tts/0 and usb/tts/1 devices don't appear to work
properly and am wondering if the failures on ezusb_set_reset_R9a81da3a-
and ezusb_writememory are to blame. Is anyone else seeing this?
                        Jack

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
