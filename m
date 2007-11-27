Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8F404DDDF7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Nov 2007 08:38:34 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1Ix88V-0006pw-G5
	for linuxppc-embedded@ozlabs.org; Tue, 27 Nov 2007 13:38:31 -0800
Message-ID: <13980499.post@talk.nabble.com>
Date: Tue, 27 Nov 2007 13:38:31 -0800 (PST)
From: khollan <khollan@daktronics.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Debugging with gdbserver slow
In-Reply-To: <13865715.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <13865715.post@talk.nabble.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Fixed.  It turns out it was because I'm using VMWare to run Linux on my
windows computer.  I booted up Linux natively and it stepped through code
very fast even in multi threaded apps.

-- 
View this message in context: http://www.nabble.com/Debugging-with-gdbserver-slow-tf4846374.html#a13980499
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
