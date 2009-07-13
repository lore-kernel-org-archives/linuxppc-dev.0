Return-Path: <bounces@nabble.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B8380B7066
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 13 Jul 2009 17:00:40 +1000 (EST)
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 5531FDDDA2
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Jul 2009 17:00:40 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1MQFWb-0008Fz-PP
	for linuxppc-dev@ozlabs.org; Mon, 13 Jul 2009 00:00:33 -0700
Message-ID: <24457031.post@talk.nabble.com>
Date: Mon, 13 Jul 2009 00:00:33 -0700 (PDT)
From: "Sauce.Cheng" <chmhou@sina.com>
To: linuxppc-dev@ozlabs.org
Subject: mmap() problem in own driver
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


Hi everyone
there is a problem of my own driver

I want to get data from kernel space to user space indirectly using mmap()
but i dont know how I can do , anyone can give me some advices ?

firstly, fetch data by DMA to a memory allocated by "kmalloc"
then i want to mmap it to user space and save the data as a file 

Cheers everyone~
Martin
-- 
View this message in context: http://www.nabble.com/mmap%28%29-problem-in-own-driver-tp24457031p24457031.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
