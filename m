Message-ID: <6DF87017DA95D611AC6000606730DE9B1B51D5@BLREXSR>
From: Nageswari S <nageswari@sanyo.co.in>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: USB - Interrupt problem
Date: Mon, 18 Nov 2002 11:56:04 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
I have a custom PowerPC board (IBM 405 Based) with USB - OHCI compliant
controller on OPB bus. I have taken SA1111 usb driver as a refernce and
enabled USB. The root hub got initialised and
cat /proc/bus/usb/devices outputs


" T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=
" B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
" D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxP
" P:  Vendor=0000 ProdID=0000 Rev= 0.00
" S:  Product=USB OHCI Root Hub
" S:  SerialNumber=ef601200
" C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
" I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00
" E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

but, there is no change in interrupts when I connect a USB device.
cat /proc/interrupts output is


           CPU0
  2:     119608  405IAP UIC Edge      NE2000
 11:          1  405IAP UIC Edge      usb-ohci
 29:        604  405IAP UIC Edge      keyboard
BAD:          0

Also, whatever device I connect, it does not get listed in
/proc/bus/usb/devices
Could anybody please tell me as to where the problem is regarding the
interrupts.


Any help or suggestion would be very helpful....

Thank you for your time....

regards,
Nageswari

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
