Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D980FDDEB6
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  3 Jul 2007 06:58:50 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1I5Syo-0007dx-GN
	for linuxppc-embedded@ozlabs.org; Mon, 02 Jul 2007 13:58:42 -0700
Message-ID: <11401755.post@talk.nabble.com>
Date: Mon, 2 Jul 2007 13:58:42 -0700 (PDT)
From: khollan <khollan@daktronics.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Porting Linux to Xilinx ML410
In-Reply-To: <11328063.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <11328063.post@talk.nabble.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Im trying to mount the root file system off of compact flash and now I get
this happening during boot

xsysace xsa: kicking stalled fsm; state=2 task=0 iter=1 dc=0
xsysace xsa: kicking stalled fsm; state=2 task=0 iter=1 dc=0
xsysace xsa: kicking stalled fsm; state=2 task=0 iter=1 dc=0

any ideas what this is and how to fix it?  I tried applying a patch that
talked about this but my version of xsysace.c already had those changes.

Thanks

Kevin
-- 
View this message in context: http://www.nabble.com/Porting-Linux-to-Xilinx-ML410-tf3989483.html#a11401755
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
