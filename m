Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AA37ADDDDB
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  6 Jul 2007 06:23:35 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1I6XrO-0000OB-Bh
	for linuxppc-embedded@ozlabs.org; Thu, 05 Jul 2007 13:23:30 -0700
Message-ID: <11453962.post@talk.nabble.com>
Date: Thu, 5 Jul 2007 13:23:30 -0700 (PDT)
From: khollan <khollan@daktronics.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Porting Linux to Xilinx ML410
In-Reply-To: <fa686aa40707021551y469e1b7fv3b8c329b904b3d6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <11328063.post@talk.nabble.com> <11401755.post@talk.nabble.com>
	<fa686aa40707021551y469e1b7fv3b8c329b904b3d6@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Thanks I fixed the error, my system ace hardware wasn't working correctly.
Now I have a new problem during the init process.  It gives me this message

Starting pid 213 tty '': '/sbin/getty'
process '/sbin/getty 9600 ttyUL0 (pid 213) exited. Scheduling it for
restart.

And it tries to respawn it indefinetly.
If I pass the kernel command Init=/bin/sh I can get into the shell correctly
Any Ideas what this problem is?
Thanks for your help
Kevin
-- 
View this message in context: http://www.nabble.com/Porting-Linux-to-Xilinx-ML410-tf3989483.html#a11453962
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
