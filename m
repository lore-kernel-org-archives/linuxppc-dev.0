Return-Path: <Orges.Furxhi@thyssenkrupp.com>
Received: from mail002.triaton.com (mail002.triaton.com [149.250.222.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "mail002.triaton.com",
	Issuer "TC TrustCenter for Security in Data Networks GmbH" (not
	verified)) by ozlabs.org (Postfix) with ESMTP id 8D3A767A3A
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 Aug 2006 02:35:24 +1000 (EST)
Message-ID: <162B449665D6D643AD9E1D50FC6F4B14042F1C9D@mdcexc05.na.ops.local>
From: "Furxhi, Orges" <Orges.Furxhi@thyssenkrupp.com>
To: "'Roman Fietze'" <roman.fietze@telemotive.de>, "Furxhi, Orges"
	<Orges.Furxhi@thyssenkrupp.com>
Subject: RE: USB flashdrive on Motorola MPC5200 (IceCube) board, linux ker
	nel 2.4.25 (DENX drop)
Date: Mon, 31 Jul 2006 11:35:23 -0500
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello, 

Thanks for responding,

> > usb.c: USB device not accepting new address=2 (error=-110)
> 
> We had that problem on a few of our boards as well.
> 
> For the old Icecube exists the possibility to mount two different USB
> transceivers, one of them the ISP1107DH, the other one the
> P11PAPW. Which one of the two is mounted on your board?

The Icecube board has the USBP11A transceiver and our custom board has 	the
ISP1105 (this has a problem with low speed devices according to PHILIPS).  

 
> On our own boards we had problems with low speed devices and the
> ISP1107, the other transceiver that Freescale used worked
> fine. Connecting those low speed devices via a hub worked. 

We get the same message when we connect the hub itself to the USB port
Does anything need to be configured in the kernel to accept the USB hub, if
so which switch is it?
  

> We ended up using a Fairchild USB1T11A, the ISP1107 seemed to have a
> problem, we just didn't have luck with them. The Fairchild's are pin
> compatible, maybe you just give it a try.

I'll relay this to our hardware guys.


Thanks,

Orges
