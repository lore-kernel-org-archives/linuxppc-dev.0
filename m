Return-Path: <benjamin.collar@siemens.com>
Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BD4C92BD6A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Oct 2004 03:11:35 +1000 (EST)
Received: from mail1.siemens.de (mail1.siemens.de [139.23.33.14])
	by thoth.sbs.de (8.12.6/8.12.6) with ESMTP id i9JG5xfO010689
	for <linuxppc-embedded@ozlabs.org>; Tue, 19 Oct 2004 18:05:59 +0200
Received: from mhpajh5c (mhpajh5c.mchp.siemens.de [139.23.185.152])
	by mail1.siemens.de (8.12.6/8.12.6) with ESMTP id i9JG5xma019989
	for <linuxppc-embedded@ozlabs.org>; Tue, 19 Oct 2004 18:05:59 +0200
From: Benjamin Collar <benjamin.collar@siemens.com>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Tue, 19 Oct 2004 18:04:36 +0200
Message-Id: <1098201876.24721.79.camel@mhpajh5c>
Mime-Version: 1.0
Subject: question 1: printk works, outputting to /dev/console and/or
	/dev/ttyS0 doesn't
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Greetings folks

I'm attempting to get a board with an MPC852T up and running. The
subject line pretty much explains what my problem is: printk works just
fine, but I get absolutely no output from writing in userland
to /dev/console or /dev/ttyS0. Does anyone have any idea what that would
be so? Or where I should look to find the problem?

Thanks
Ben

-- 
Benjamin Collar
Siemens AG
CT SE 2
Embedded Linux
089-636-53711
