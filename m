Return-Path: <rvinson@mvista.com>
Received: from zipcode.az.mvista.com (rav-az.mvista.com [65.200.49.157])
	by ozlabs.org (Postfix) with ESMTP id 0643C2BE83
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Dec 2004 09:30:08 +1100 (EST)
Message-ID: <41B7821B.7070001@mvista.com>
Date: Wed, 08 Dec 2004 15:37:15 -0700
From: Randy Vinson <rvinson@mvista.com>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: akpm@osdl.org
Subject: [PATCH][PPC32] Add Support for IBM 750FX and 750GX Eval Boards
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Greetings,
   I've added support for the IBM 750FX and 750GX Eval Boards
(Chestnut/Buckeye). This patch is against 2.6.10-rc3. The patch relies
on the 2 MV64x60 patches and the EV64260 patch previously posted by M.
Greer. Please apply.

Signed-off-by: Randy Vinson <rvinson@mvista.com>

My patch is over the 40K limit, so it can be found at
ftp://source.mvista.com/pub/rvinson/chestnut.patch


	Thanks
	Randy Vinson
