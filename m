Message-Id: <200404080133.i381XW6P017976@ms.usish.com>
From: "Jack Liu" <Jack_liu@usish.com>
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: USB 2.0 problem
Mime-Version: 1.0
Content-Type: text/plain
Date: Thu, 8 Apr 2004 09:32:59 +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi,all
 I am using NEC uPD720101 USB chip. It has two OHCI and one EHCI. USB1.1
works ok. When I enable EHCI, system hangs when I plugged one 2.0
device. I thought maybe it is becuase of the overcurrent protection, I
used one external-power supply for the device. Yet the same thing. The
debugging infomation as below:

	port 1, portstatus 501, change 1, 480 Mb/s<6>hub.c: new USB device 00:0e.2-1, assigned address 2
	enter usb_new_device()
    EHCI enter ehci_irq()
    devpath 1 ep0out 3strikes token = 80248
    QTD_STS_XACT
    exit ehci_iqr
    USB device not accepting new address=2 (error=-71)
    EHCI enter ehci_irq()
    exit ehci_iqr
    now exit usb_hub_port_connect_change()
    port 1, portstatus 101, change 1, 12 Mb/sUSI: recv a ARP pkt source 56.198
    enter usb_new_device()
    we now enter hc_interrupt()
    USB device not accepting new address=2 (error=-110)
    enter usb_new_device()

    So what could be the problem?

Best regards
Jack liu

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
