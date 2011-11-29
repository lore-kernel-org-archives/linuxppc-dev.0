Return-Path: <Kyle.D.Moffett@boeing.com>
Received: from border.exmeritus.com (border.exmeritus.com
 [IPv6:2002:46a7:f11a:ffff::])
 by ozlabs.org (Postfix) with ESMTP id CECB11007D1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2011 05:59:28 +1100 (EST)
From: Kyle Moffett <Kyle.D.Moffett@boeing.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 00/10] powerpc/mpic: General cleanup patch series
Date: Tue, 29 Nov 2011 13:58:27 -0500
Message-Id: <1322593117-29938-1-git-send-email-Kyle.D.Moffett@boeing.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

As BenH requested, this is the version-2 repost of the PowerPC MPIC
cleanup patch series.

All of the review comments have been addressed, and I have performed
build and boot testing on our HWW-1U-1A hardware with these patches
applied (plus a few independent board-support patches).

Unfortunately, this has a potentially very broad impact across a wide
variety of hardware that I don't have the ability to test with, so
any additional testing will be highly appreciated.  Ben has indicated
that he plans to put it into his testing tree soon, so hopefully any
such issues will get ironed out quickly.

Cheers,
Kyle Moffett
