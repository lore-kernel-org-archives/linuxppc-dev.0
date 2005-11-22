Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 80BD5687BA
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Nov 2005 14:23:47 +1100 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EeOiv-0003fO-OP
	for linuxppc-embedded@ozlabs.org; Tue, 22 Nov 2005 04:21:38 +0100
Received: from dsl-202-45-109-210.vic.netspace.net.au ([202.45.109.210])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Tue, 22 Nov 2005 04:21:37 +0100
Received: from ronkbox-news by dsl-202-45-109-210.vic.netspace.net.au with
	local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Tue, 22 Nov 2005 04:21:37 +0100
To: linuxppc-embedded@ozlabs.org
From: Ron Kellam <ronkbox-news@yahoo.com>
Date: Tue, 22 Nov 2005 14:19:49 +1100
Message-ID: <0g35o11r5q9uphiqgoql39incpdfb9apri@4ax.com>
References: <qpr2o1dhoelk8rt11jl3lbangfs0hj710a@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@sea.gmane.org>
Subject: anyone used i2c-algo-8260 for the MPC8272 family?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm posting this just to capture the solution.  An actual patch may
follow sometime down the track.

By looking over some code I got from Dave Bruce (thanks Dave!), I
tried replacing the use of __pa() with iopa().  With just this change,
the driver now "works for me".

I'm not sure of the details of the difference.  Anyone care to
elaborate?

By the way, as stated in another thread, I'm working with a
denx-2.4.25 kernel.

Regards,
Ron Kellam.
