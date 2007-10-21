Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by ozlabs.org (Postfix) with ESMTP id 98D6BDDEA3
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Oct 2007 04:56:18 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so1148353wag
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Oct 2007 11:56:17 -0700 (PDT)
Message-ID: <fa686aa40710211156l3e74e028ja6e84aea29ecb3c5@mail.gmail.com>
Date: Sun, 21 Oct 2007 12:56:16 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: linuxppc-dev <linuxppc-dev@ozlabs.org>, "Paul Mackerras" <paulus@samba.org>
Subject: Fwd: Please pull linux-2.6-mpc52xx.git
In-Reply-To: <fa686aa40710211154r22d5ccbfu5f54d392aad99880@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <fa686aa40710211154r22d5ccbfu5f54d392aad99880@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paulus, please pull the following mpc52xx related changes.

The following changes since commit 2fb59d623ad85dfdb8ce03a660051743f7361896:
  Linus Torvalds (1):
        Merge branch 'audit.b43' of git://git.kernel.org/.../viro/audit-current

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6-mpc52xx.git for-2.6.24

Grant Likely (1):
      [POWERPC] bestcomm: Restrict bus prefetch bugfix to original
mpc5200 silicon.

Marian Balakowicz (4):
      [POWERPC] Add mpc52xx_find_and_map_path(), refactor utility functions
      [POWERPC] Update device tree binding for mpc5200 gpt
      [POWERPC] Add restart support for mpc52xx based platforms
      [POWERPC] Enable restart support for lite5200 board

 .../powerpc/mpc52xx-device-tree-bindings.txt       |    4 +-
 arch/powerpc/boot/dts/lite5200.dts                 |   26 +++-----
 arch/powerpc/boot/dts/lite5200b.dts                |   26 +++-----
 arch/powerpc/platforms/52xx/lite5200.c             |    4 +
 arch/powerpc/platforms/52xx/mpc52xx_common.c       |   71 ++++++++++++++++++-
 arch/powerpc/sysdev/bestcomm/bestcomm.c            |    9 ++-
 drivers/watchdog/mpc5200_wdt.c                     |    3 +
 include/asm-powerpc/mpc52xx.h                      |    9 +++
 8 files changed, 109 insertions(+), 43 deletions(-)


--
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
