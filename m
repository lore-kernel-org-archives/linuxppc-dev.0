Return-Path: <bounces@nabble.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 3A92FB723E
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 21 Jun 2009 03:54:46 +1000 (EST)
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id D46FEDDD0C
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Jun 2009 03:54:45 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1MI4m0-0006hJ-EM
	for linuxppc-dev@ozlabs.org; Sat, 20 Jun 2009 10:54:40 -0700
Message-ID: <24127643.post@talk.nabble.com>
Date: Sat, 20 Jun 2009 10:54:40 -0700 (PDT)
From: Mirek23 <miroslaw.dach@psi.ch>
To: linuxppc-dev@ozlabs.org
Subject: howto redirect serial console
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


I have a ppc405 based board with one serial interface which I use as a
console.
I would like to redirect or suppress, at run time, the console in order to
use the
serial port to control external serial devices.

I have tried (busybox) setconsole program to redirect the console to
/dev/null
but it did not work. What would be the elegant way to redirect or suppress
the serial console.

M.  
-- 
View this message in context: http://www.nabble.com/howto-redirect-serial-console-tp24127643p24127643.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
