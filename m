Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0A7D3DDD0B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Nov 2007 02:07:52 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IsgJo-0000C7-OC
	for linuxppc-embedded@ozlabs.org; Thu, 15 Nov 2007 07:07:48 -0800
Message-ID: <13770288.post@talk.nabble.com>
Date: Thu, 15 Nov 2007 07:07:48 -0800 (PST)
From: alex_snippet <alex.snippet@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Virtex TEMAC ping -s 10000 host, is it working?
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


Hi All!

On Virtex 4FX board with TEMAC core, Linux ping working fine, but if s -
parameter set to big values it freezes for ever...

Colleagues please share your experience with ping -s 10000 host.

Do you know what parameters in core or in Linux kernel must be changed to
improve it.

My customer is too hypercritical, he likes to ping :(

I tried to  increase LX/TX buffers in core, it increased dead line but there
is no desirable result.


-- 
View this message in context: http://www.nabble.com/Virtex-TEMAC-ping--s-10000-host%2C-is-it-working--tf4812989.html#a13770288
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
