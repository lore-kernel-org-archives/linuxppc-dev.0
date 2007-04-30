Return-Path: <bounces@nabble.com>
Received: from talk.nabble.com (www.nabble.com [72.21.53.35])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C9A47DDE0D
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 May 2007 01:40:51 +1000 (EST)
Received: from [72.21.53.38] (helo=jubjub.nabble.com)
	by talk.nabble.com with esmtp (Exim 4.50) id 1HiXzc-00078E-Ip
	for linuxppc-embedded@ozlabs.org; Mon, 30 Apr 2007 08:40:48 -0700
Message-ID: <10255622.post@talk.nabble.com>
Date: Mon, 30 Apr 2007 08:40:48 -0700 (PDT)
From: rvk <rvkisley@yahoo.com>
To: linuxppc-embedded@ozlabs.org
Subject: ram not at 0? anyone?
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


I've learned a little more, looking at PPC_MEMSTART from
include/asm-ppc/page.h, and it seems there is some relevant infra.  However
I'm still worried about the tophys() and tovirt() implementations used by
head_4xx.S. Can anyone comment who has experience with RAM not at physical
0? I don't have the board yet, but it will be Xilinx Virtex 4 ppc405.
-- 
View this message in context: http://www.nabble.com/ram-not-at-0--anyone--tf3670343.html#a10255622
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
