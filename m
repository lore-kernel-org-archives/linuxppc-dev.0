Return-Path: <sachinp@in.ibm.com>
Received: from e23smtp04.au.ibm.com (unknown [202.81.31.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 63D0947525
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Feb 2009 02:22:16 +1100 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp04.au.ibm.com (8.13.1/8.13.1) with ESMTP id n13FE1mu016065
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Feb 2009 02:14:01 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n13FG37P291312
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Feb 2009 02:16:03 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n13FFidZ009709
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Feb 2009 02:15:45 +1100
Message-ID: <49885F9A.6040703@in.ibm.com>
Date: Tue, 03 Feb 2009 20:45:38 +0530
From: "Sachin P. Sant" <sachinp@in.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: 2.6.29-rc3-git5 build failure : drivers/staging/panel
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Mel Gorman <mel@csn.ul.ie>, greg@kroah.com, Willy Tarreau <w@1wt.eu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

2.6.29-rc3-git5 randconfig build on powerpc fails with following error

 CALL    arch/powerpc/kernel/systbl_chk.sh
 CALL    arch/powerpc/kernel/prom_init_check.sh
 CC [M]  drivers/staging/panel/panel.o
drivers/staging/panel/panel.c:625: error: conflicting types for set_bits
/home/sachin/linux-2.6.29-rc3-git5/arch/powerpc/include/asm/bitops.h:216: error: previous definition of set_bits was here
make[3]: *** [drivers/staging/panel/panel.o] Error 1
make[2]: *** [drivers/staging/panel] Error 2
make[1]: *** [drivers/staging] Error 2
make: *** [drivers] Error 2

Will provide .config if required.

Thanks
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
