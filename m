Message-ID: <D73A25AA6E54D511AD74009027B1110F5BB050@ORION>
From: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: usb driver requries pdev?
Date: Tue, 3 Feb 2004 13:24:46 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have been looking through the USB driver for the latest linuxppc_2_4_devel
tree at ppc.bkbits.net and I spotted something that looks like a bug.  I did
a search through the list and did not see any mention of it.

In drivers/usb/hcd.h  the declaration of pdev is in #ifdef CONFIG_PCI
#endif.

In drivers/usb/hcd.c  I see pdev used several times but it is not in #ifdef
CONFIG_PCI   #endif.

The make file forces hcd.c to be compiled when USB support is enabled but if
the board does not have PCI the compile will fail because of this.

Steve Blakeslee

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
