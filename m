Return-Path: <prvs=16695eb497=steve@digidescorp.com>
Received: from digidescorp.com (mail.digidescorp.com [66.244.163.200])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4615BB7CB6
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Feb 2010 04:48:48 +1100 (EST)
Received: from localhost.localdomain by digidescorp.com (Cipher
	TLSv1:RC4-MD5:128) (MDaemon PRO v10.1.1)
	with ESMTP id md50001203880.msg
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Feb 2010 11:40:25 -0600
From: "Steven J. Magnani" <steve@digidescorp.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: [async_tx-next PATCH 0/2] fsldma: Fix cookie issues
Date: Mon, 22 Feb 2010 11:40:07 -0600
Message-Id: <1266860407-17287-1-git-send-email-steve@digidescorp.com>
Cc: Zhang Wei <zw@zh-kernel.org>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In modeling a new DMA engine on the FSL code, I ran across what look to be
some bugs in FSL cookie handling. As I don't have FSL HW or even a PPC, 
I can't verify the problem or the fix, but I did ensure that the changes 
compile.

BTW thanks to all involved in creation of the FSL driver, it's a nice model
to follow.

Regards,
------------------------------------------------------------------------
 Steven J. Magnani               "I claim this network for MARS!
 www.digidescorp.com              Earthling, return my space modulator!"

 #include <standard.disclaimer>
