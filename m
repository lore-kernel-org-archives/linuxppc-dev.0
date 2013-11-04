Return-Path: <joseph_myers@mentor.com>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "relay1.mentorg.com",
 Issuer "Entrust Certification Authority - L1C" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9C0BD2C0335
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Nov 2013 03:50:55 +1100 (EST)
Date: Mon, 4 Nov 2013 16:50:43 +0000
From: "Joseph S. Myers" <joseph@codesourcery.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 0/6] powerpc/math-emu: e500 SPE float emulation fixes
Message-ID: <Pine.LNX.4.64.1311041649250.4290@digraph.polyomino.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: Joseph Myers <joseph@codesourcery.com>
Cc: Liu Yu <yu.liu@freescale.com>, linux-kernel@vger.kernel.org,
 Shan Hai <shan.hai@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series fixes various problems with the floating-point
emulation code for powerpc e500 SPE (some being issues with the
e500-specific emulation code, some with the generic math-emu headers).
All six patches were sent individually last month as the issues were
identified and fixed in the course of preparing the e500 glibc port,
and received no comments.  There are no substantive changes to the
patches in this version, but I've retested the glibc port (which is
now upstream, along with all the generic math-emu changes relevant to
the glibc soft-fp code, and various fixes to soft-fp corresponding to
fixes in the kernel code in the hope that at some point we can get the
kernel using the current soft-fp code again) with current kernel
sources with this patch series applied.

The only dependencies between patches in this series should be that
patch 5 (fix e500 SPE float to integer and fixed-point conversions)
depends on patch 2 (fix e500 SPE float rounding inexactness
detection).  Other than that, I think any subset of the patches can be
applied in any order, if some subset seems OK but there are concerns
about other patches in the series.

-- 
Joseph S. Myers
joseph@codesourcery.com
