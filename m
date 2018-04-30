Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Z6JP0rYyzF257
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Apr 2018 11:24:03 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id n9-v6so5254455pgq.5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Apr 2018 18:24:03 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linux-kbuild@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 0/2] powerpc patches for new Kconfig language
Date: Mon, 30 Apr 2018 11:23:49 +1000
Message-Id: <20180430012351.28814-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I was taking a look at this nice new Kconfig feature here:

https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git/log/?h=kconfig-shell-v3

And came up with some patches for it for powerpc. Hopefully after
some review, these patches could be acked by powerpc maintainers and
go into the kbuild tree (or the problems solved a different way).

Thanks,
Nick

Nicholas Piggin (2):
  powerpc/kbuild: Use flags variables rather than overriding LD/CC/AS
  powerpc/kbuild: move -mprofile-kernel check to Kconfig

 arch/powerpc/Kconfig                          | 16 +----------
 arch/powerpc/Makefile                         | 28 ++++++-------------
 .../tools/gcc-check-mprofile-kernel.sh        |  4 +--
 3 files changed, 12 insertions(+), 36 deletions(-)

-- 
2.17.0
