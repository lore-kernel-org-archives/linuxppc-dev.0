Return-Path: <Qingtao.Cao@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 00293DE239
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Apr 2009 15:51:58 +1000 (EST)
From: Harry Ciao <qingtao.cao@windriver.com>
To: akpm@linux-foundation.org, michael@ellerman.id.au, galak@gate.crashing.org,
	bluesmoke-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org
Subject: [v3 PATCH 3/3] EDAC: CPC925 MC platform device setup
Date: Thu, 16 Apr 2009 13:51:02 +0800
Message-Id: <1239861063-22837-1-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <>
References: <>
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi Andrew and Michael,

This is the modified 3/3 patch that corrects CPC925 memory controller DTB node on Maple and setup related platform device for CPC925 EDAC driver. Michael's suggestion of being more discernible for the Maple platform only has been adopted.

v2 1/3 & 2/3 patches have been in -mm tree and I don't have to re-send them again. Test passed for this v3 3/3 patch.

Thanks!

Best regards,

Harry
