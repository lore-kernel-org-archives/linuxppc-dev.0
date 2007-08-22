Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C7736DDE48
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Aug 2007 16:33:01 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1INjly-0001ky-AH
	for linuxppc-dev@ozlabs.org; Tue, 21 Aug 2007 23:32:58 -0700
Message-ID: <12268833.post@talk.nabble.com>
Date: Tue, 21 Aug 2007 23:32:58 -0700 (PDT)
From: sivaji <rameshmrm@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: 2.6.23-rc3 is not booting
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hai,
         I am using the kernel 2.6.23-rc3. i am trying to boot this kernel
to my 8641D board. It was not booting.
I go the following message 

Bytes transferred = 1505 (5e1 hex)
## Booting image at 00200000 ...
   Image Name:   Linux-2.6.23-rc3
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1801717 Bytes =  1.7 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
   Booting using flat device tree at 0x800000

Whether the problem belongs to device tree? I am using the mpc8641_hpcn.dts
file 

Pls Advice me.

-- 
View this message in context: http://www.nabble.com/2.6.23-rc3-is-not-booting-tf4309661.html#a12268833
Sent from the linuxppc-dev mailing list archive at Nabble.com.
