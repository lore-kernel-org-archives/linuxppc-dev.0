Return-Path: <BATV+bfa31428277ec1635a02+3390+infradead.org+dwmw2@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:4830:2446:ff00:4687:fcff:fea6:5117])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E5AD82C008E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2012 21:15:52 +1100 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: dwmw2@infradead.org
Subject: [PATCH 0/4] Use compiler intrinsics for byteswapping
Date: Tue,  4 Dec 2012 10:15:26 +0000
Message-Id: <1354616130-21587-1-git-send-email-dwmw2@infradead.org>
Cc: linux-arch@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series of patches enables the __builtin_bswapXX() series of functions
that have been supported since GCC 4.4. It allows GCC to emit load-and-swap
or store-and-swap instructions on architectures which support that.

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation
