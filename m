Message-Id: <4.2.2.20010830111127.02d754d0@qisrael.qi.qualcomm.com>
Date: Thu, 30 Aug 2001 12:19:52 +0300
To: linuxppc-embedded@lists.linuxppc.org
From: Alexander Kolesnikov <akolesni@qualcomm.com>
Subject: USB support in the HardHet Linux 2.4.2 on the IBM Walnut
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,

We have problems with different USB chips on the Walnut board:

1.Using of a OHCI chip causes to kernel crash. This problem is famous but
we really need to know whether does any "on the shelf" solution for the
particular case exist.

2.When a UHCI chip is used, the USB device connecting to it causes to the
following error messages:

	usb_control/buk_msg:timeout
	usb.c:USB device not accepting new address = XX (error=-110)

The used USB hubs and devices work properly with another OS on the PC
platform.

Thanks in advance.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
