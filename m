Return-Path: <lin.sunze@gmail.com>
Received: from mail-pf0-f194.google.com (mail-pf0-f194.google.com
 [209.85.192.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xKHKw5Kw2zDrLs
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Jul 2017 17:25:08 +1000 (AEST)
Received: by mail-pf0-f194.google.com with SMTP id r63so1260039pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Jul 2017 00:25:08 -0700 (PDT)
From: SZ Lin <sz.lin@moxa.com>
To: ashleydlai@gmail.com
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 peterhuewe@gmx.de, tpmdd@selhorst.ne, jarkko.sakkinen@linux.intel.com,
 jgunthorpe@obsidianresearch.com, tpmdd-devel@lists.sourceforge.net,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 SZ Lin <sz.lin@moxa.com>
Subject: [PATCH 0/5] tpm: tpm_ibmvtpm: - style fix
Date: Sat, 29 Jul 2017 15:24:28 +0800
Message-Id: <20170729072433.13194-1-sz.lin@moxa.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix styling WARNINGs and Errors of tpm_ibmvtpm.c driver by using checkpatch.pl

SZ Lin (5):
  Fix packed and aligned attribute warnings.
  Fix "ERROR: code indent should use tabs where possible"
  Fix 'void function return statements are not generally useful' warning
  Remove unneccessary 'out of memory' message
  Use __func__ instead of function name

 drivers/char/tpm/tpm_ibmvtpm.c | 23 +++++++++--------------
 drivers/char/tpm/tpm_ibmvtpm.h |  2 +-
 2 files changed, 10 insertions(+), 15 deletions(-)

--
2.13.3
