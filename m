Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BB9B3DE403
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 29 Mar 2008 03:12:43 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1JfHC4-0001Vz-3G
	for linuxppc-embedded@ozlabs.org; Fri, 28 Mar 2008 09:12:40 -0700
Message-ID: <16352982.post@talk.nabble.com>
Date: Fri, 28 Mar 2008 09:12:40 -0700 (PDT)
From: BAK <khaled.benamor@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: video driver problems on set top box board
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


I am working ST set top box board and I need help to resolve some problems.
if you 're working on set top box or you have experience with them these are
more detailed informations:

I am using a set top box board : STB442 based on STi7109 chip. I use STAPI
(drivers provided by ST) with STlinux kernell. I have some problems with a
module (named mme_host) which must be inserted with arguments (insmod
mme_host.ko transport0=<arguments_to_be_used>). This operation causes the
following error :
insmod: error inserting '/home/bakhaled/modules/mme/mme_host.ko': -1
Operation not permitted
I tried to insert the module without arguments (insmod mme_host.ko) and
this was successful. But when I try to run a test program for video ,
after inserting that mme module without arguments, the system crash down.
(don't execute console commands).
Has any one experienced this type of problems?
Have you any solutions ?
-- 
View this message in context: http://www.nabble.com/video-driver-problems-on-set-top-box-board-tp16352982p16352982.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
