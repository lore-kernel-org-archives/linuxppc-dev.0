Return-Path: <Qingtao.Cao@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 64147DE11C
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Apr 2009 16:11:35 +1000 (EST)
From: Harry Ciao <qingtao.cao@windriver.com>
To: norsk5@yahoo.com, michael@ellerman.id.au,
	bluesmoke-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org
Subject: [v2 PATCH 0/3] Add CPC925 Memory Controller EDAC drivers
Date: Mon, 13 Apr 2009 14:05:13 +0800
Message-Id: <1239602716-18352-1-git-send-email-qingtao.cao@windriver.com>
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi Doug and Michael,

This is the latest v2 patches, the 1/3 of CPC925 MC EDAC driver remains
the same as before, the 2/3 has been pushed to Andrew already, and the 
3/3 has integrated Michael's suggestions to add a fixup routine for the 
memory controller on Maple that has incorrect number of cells, and create
related platform_device for CPC925 on Motorola ATCA-6101 target by far.

All patches have been tested, please give me your further concerns or 
suggestions, thanks!

Best regards,

Harry
