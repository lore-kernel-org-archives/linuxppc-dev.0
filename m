Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B60A2DDE11
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Sep 2007 16:39:04 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1ISS3u-0005gb-7t
	for linuxppc-dev@ozlabs.org; Mon, 03 Sep 2007 23:38:58 -0700
Message-ID: <12472670.post@talk.nabble.com>
Date: Mon, 3 Sep 2007 23:38:58 -0700 (PDT)
From: sivaji <rameshmrm@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Regarding immap_86xx.h
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


Hi,
         I am using 2.6.23-rc3 kernel. In this kernel immap_86xx.h file was
loacted in the path: include/asm-powerpc/immap_86xx.h.
        
          This file contains only PCI and Global utility Regsiters
Declarations. LocalBus Controller, Local Access Registers and Rapid IO
Register Declarations are missing.   Where i can find these registers
declaration and tell the reason why the CCSRBAR Registers are missing in the
file immap_86xx.h

by
Sivaji
           
-- 
View this message in context: http://www.nabble.com/Regarding-immap_86xx.h-tf4375801.html#a12472670
Sent from the linuxppc-dev mailing list archive at Nabble.com.
