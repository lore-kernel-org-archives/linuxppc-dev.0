Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 70008DDE06
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Nov 2007 02:21:22 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IuUud-0001tJ-0M
	for linuxppc-embedded@ozlabs.org; Tue, 20 Nov 2007 07:21:19 -0800
Message-ID: <13858912.post@talk.nabble.com>
Date: Tue, 20 Nov 2007 07:21:19 -0800 (PST)
From: Lorenz Kolb <linuxppcemb@lkmail.de>
To: linuxppc-embedded@ozlabs.org
Subject: ML403 USB driver
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi,

we just tried the USB driver (from Peter Korsgaard) from Grant's virtex
tree.

Nevertheless we could not get the peripheral ports work as gadgets.
Has anyone tried (and probably fixed) that before?

Anyway, only one of the two peripheral ports seems to be active.

We use kernel 2.6.22 (as some usb related stuff has recently changed and the
driver would have to be changed), usb host works (usb-storage, cdc_ether,
some more stuff we tested)

Regards,

Lorenz Kolb
-- 
View this message in context: http://www.nabble.com/ML403-USB-driver-tf4844098.html#a13858912
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
