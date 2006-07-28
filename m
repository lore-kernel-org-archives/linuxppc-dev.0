Return-Path: <Orges.Furxhi@thyssenkrupp.com>
Received: from mail001.triaton.com (mail001.triaton.com [149.250.222.55])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "mail001.triaton.com",
	Issuer "TC TrustCenter for Security in Data Networks GmbH" (not
	verified)) by ozlabs.org (Postfix) with ESMTP id B618A67A2E
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 29 Jul 2006 08:08:04 +1000 (EST)
Message-ID: <162B449665D6D643AD9E1D50FC6F4B14042F1C9A@mdcexc05.na.ops.local>
From: "Furxhi, Orges" <Orges.Furxhi@thyssenkrupp.com>
To: "Furxhi, Orges" <Orges.Furxhi@thyssenkrupp.com>, "'Wolfgang Denk'"
	<wd@denx.de>
Subject: RE: USB flashdrive on Motorola MPC5200 (IceCube) board, linux ker
	nel 2.4.25 (DENX drop)
Date: Fri, 28 Jul 2006 17:07:48 -0500
MIME-Version: 1.0
Content-Type: text/plain
Cc: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


>Which defconfig file should I use? 
>I just tried the icecube_5200_CoralP_defconfig file but now the board isnot
>booting; it hangs right after this message:


I figured out my mistake as far as booting the kernel, I did not have the
right bootm argument.
Even with the I figured out my mistake as far as booting the kernel, I did
not have the correct bootargs. 

Even with the icecube_5200_CoralP_defconfig +scsi support, and usb
mas-storage enabled, I get the same message when I plug in the usb stick. 

usb.c: USB device not accepting new address=2 (error=-110)



Orges
