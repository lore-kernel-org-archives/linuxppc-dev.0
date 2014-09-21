Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0021.hostedemail.com
 [216.40.44.21])
 by lists.ozlabs.org (Postfix) with ESMTP id 7E06B1A011F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Sep 2014 04:02:59 +1000 (EST)
Received: from smtprelay.hostedemail.com (ff-bigip1 [10.5.19.254])
 by smtpgrave02.hostedemail.com (Postfix) with ESMTP id A6F094985
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Sep 2014 17:55:12 +0000 (UTC)
From: Joe Perches <joe@perches.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] powerpc: pci-ioda: Neatening
Date: Sun, 21 Sep 2014 10:55:04 -0700
Message-Id: <cover.1411320262.git.joe@perches.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

printk calls should return void

Joe Perches (2):
  powerpc: pci-ioda: Remove unnecessary return value from printk
  powerpc: pci-ioda: Use a single function to emit logging messages

(compiled/untested)

 arch/powerpc/platforms/powernv/pci-ioda.c | 61 +++++++++++++++----------------
 1 file changed, 30 insertions(+), 31 deletions(-)

-- 
1.8.1.2.459.gbcd45b4.dirty
