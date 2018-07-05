Return-Path: <rdunlap@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41M9xx4pRWzF266
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jul 2018 07:30:29 +1000 (AEST)
To: linux-kbuild <linux-kbuild@vger.kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@lists.ozlabs.org
From: Randy Dunlap <rdunlap@infradead.org>
Subject: powerpc: 32BIT vs. 64BIT (PPC32 vs. PPC64)
Message-ID: <3f906b03-98ff-c081-4e19-b490f0b35c51@infradead.org>
Date: Thu, 5 Jul 2018 14:30:24 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Is there a good way (or a shortcut) to do something like:

$ make ARCH=powerpc O=PPC32 [other_options] allmodconfig
  to get a PPC32/32BIT allmodconfig

and also be able to do:

$make ARCH=powerpc O=PPC64 [other_options] allmodconfig
  to get a PPC64/64BIT allmodconfig?


Note that arch/x86, arch/sh, and arch/sparc have ways to do
some flavor(s) of this (from Documentation/kbuild/kbuild.txt;
sh and sparc based on a recent "fix" patch from me):

x86: i386 for 32 bit, x86_64 for 64 bit
sh: sh for 32 bit, sh64 for 64 bit
sparc: sparc32 for 32 bit, sparc64 for 64 bit


thanks,
-- 
~Randy
