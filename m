Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C9F31DDEEA
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  8 Sep 2007 01:23:48 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1ITfgO-0000Ri-QM
	for linuxppc-embedded@ozlabs.org; Fri, 07 Sep 2007 08:23:44 -0700
Message-ID: <12557406.post@talk.nabble.com>
Date: Fri, 7 Sep 2007 08:23:44 -0700 (PDT)
From: Mirek23 <miroslaw.dach@psi.ch>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Flash paritioning and JFFS2
In-Reply-To: <1187885337.5160.55.camel@louie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <12293748.post@talk.nabble.com> <1187885337.5160.55.camel@louie>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi Michael,

>The partition information probably should go in a file that you create
>for your board located at "drivers/mtd/maps/<your_file>.c"

        Thank you very much for your answer. I went through the links you
suggested.
I got a main concept how to setup the kernel to deal with Flash and JFFS2
but I do not know in which file 
should be hardcoded the partition table and what should be its name. I have
the Flash memory which is CFI 
compliant (Intel NOR Flash TE28F640 J3C120) so I presume that for it is a
default driver?
Do I have to create a specific file for it in drivers/mtd/maps/ ?

Best Regards 

Mirek

-- 
View this message in context: http://www.nabble.com/Flash-paritioning-and-JFFS2-tf4317566.html#a12557406
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
