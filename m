Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 802FFB7B6C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Aug 2009 13:34:29 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E12D3DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2009 13:34:28 +1000 (EST)
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain
Date: Thu, 27 Aug 2009 13:33:48 +1000
Message-Id: <1251344028.20467.8.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Linus !

Here are a couple of last minute patches for 2.6.31. One is a regression fix
(afaik) where a PS3 driver gets incorrectly loaded on other platforms and
crashes, along with a PS3 defconfig update.
The following changes since commit f415c413f458837bd0c27086b79aca889f9435e4:
  Linus Torvalds (1):
        Merge git://git.kernel.org/.../davem/net-2.6

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

Geert Uytterhoeven (1):
      powerpc/ps3: Add missing check for PS3 to rtc-ps3 platform device registration

Geoff Levand (1):
      powerpc/ps3: Update ps3_defconfig

 arch/powerpc/configs/ps3_defconfig |  211 +++++++++++++-----------------------
 arch/powerpc/platforms/ps3/time.c  |    4 +
 2 files changed, 79 insertions(+), 136 deletions(-)
