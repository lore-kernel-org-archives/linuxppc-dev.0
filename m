Return-Path: <achim.machura@berghof.com>
Received: from pegasus.berghof.com (unknown [145.253.135.72])
	by ozlabs.org (Postfix) with ESMTP id 21BF267EAB
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Aug 2005 21:44:26 +1000 (EST)
Received: from BATEEE52 (batee-e52.be-int [10.255.241.52])
	by pegasus.berghof.com (8.12.10/8.12.10) with SMTP id j74BLw6O021274
	for <linuxppc-embedded@ozlabs.org>; Thu, 4 Aug 2005 13:21:58 +0200
From: "Achim Machura" <achim.machura@berghof.com>
To: "Linuxppc-Embedded \(E-Mail\)" <linuxppc-embedded@ozlabs.org>
Date: Thu, 4 Aug 2005 13:21:52 +0200
Message-ID: <00a501c598e6$b7823130$34f1ff0a@beint.local>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: USB + MPC5200 L25R REV 2 OCT0511C
Reply-To: achim.machura@berghof.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Helo list,

do everybody know about problems with usb (usb-ohci) and MPC5200 label  L25R
REV 2 OCT0511C.

When i plugg in a usb-device, i see that the kernel will assign an address
to the device, but it failed by timeout.

The same kernel an the same usb-device works fine on a board with a cpu
label 0L25R QAH0410

best regards

Achim

____________________________________________
Achim Machura Softwareentwicklung
Berghof Automationstechnik GmbH
Harretstrasse 1, D-72800 Eningen u.A.
Tel: +49-7121-894-131, Fax: +49-7121-894-100
email: machura@berghof.com
Internet: http://www.berghof.com
