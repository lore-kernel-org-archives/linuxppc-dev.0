Return-Path: <edo@onkeh.net>
Received: from pulsar.hytekhosting.com (pulsar.hytekhosting.com
	[208.101.48.101])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7D023DDEEA
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Mar 2007 06:07:59 +1100 (EST)
Received: from onkehf2 by pulsar.hytekhosting.com with local (Exim 4.63)
	(envelope-from <edo@onkeh.net>) id 1HOeQF-0006fD-0T
	for linuxppc-dev@ozlabs.org; Tue, 06 Mar 2007 13:30:03 -0500
Message-ID: <29902.81.170.115.218.1173205803.squirrel@onkeh.net>
Date: Tue, 6 Mar 2007 13:30:03 -0500 (EST)
Subject: Updated ps3fb usage?
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

Hi, I've just done a pull on Geoff's PS3 kernel git and I've noticed you
can't change the videomode as a kernel parameter in kboot.conf anymore. 
Has this feature been modified or removed completely?  I only ask because
I seem to be stuck in an unusable video mode at boot.

Thanks in advance,
