Return-Path: <bounces@nabble.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 51A1FB70B2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Jun 2009 22:55:55 +1000 (EST)
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 0717EDDD0B
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2009 22:55:54 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1MLcsI-0003xI-Q8
	for linuxppc-dev@ozlabs.org; Tue, 30 Jun 2009 05:55:50 -0700
Message-ID: <24271342.post@talk.nabble.com>
Date: Tue, 30 Jun 2009 05:55:50 -0700 (PDT)
From: Felix Radensky <felix@embedded-sol.com>
To: linuxppc-dev@ozlabs.org
Subject: Preemption question (4xx related)
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


Hi,

Preemption is disabled on the vast majority of powerpc
targets. Are there any known problems in this area ?
I'd like to enable CONFIG_PREEMPT_VOLUNTARY on
AMCC 405EX target, to increase application responsiveness.
Is it a bad idea ?
-- 
View this message in context: http://www.nabble.com/Preemption-question-%284xx-related%29-tp24271342p24271342.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
