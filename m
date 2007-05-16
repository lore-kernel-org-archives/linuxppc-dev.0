Return-Path: <edo@onkeh.net>
Received: from pulsar.hytekhosting.com (pulsar.hytekhosting.com
	[208.101.48.101])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8B8DDDDEFF
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 00:02:39 +1000 (EST)
Received: from onkehf2 by pulsar.hytekhosting.com with local (Exim 4.63)
	(envelope-from <edo@onkeh.net>) id 1HoIzP-0007Om-LH
	for linuxppc-dev@ozlabs.org; Wed, 16 May 2007 08:52:23 -0400
Message-ID: <29744.81.170.114.242.1179319943.squirrel@onkeh.net>
Date: Wed, 16 May 2007 08:52:23 -0400 (EDT)
Subject: PS3 restart crash, SCSI cache sync
From: "Edward Strong" <edo@onkeh.net>
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I've had this problem for a while but I waited until the 1.3 release kit
emerged before raising this, unfortunately it has not resolved my problem.

When I reboot the PS3, the last thing to be displayed is:

Synchronizing SCSI cache for disk sda
Synchronizing SCSI cache for disk sda

Then I get a full hardware crash and have to hit the power switch at the
back.  If I just do a shutdown, this works fine.  This error is
reproducible running both Gentoo and FC6.  I am using a 120gb Fujitsu
drive.  Does anyone know why this might be happening?

Thanks in advance,

Edward
