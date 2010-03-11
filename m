Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f197.google.com (mail-iw0-f197.google.com
	[209.85.223.197]) by ozlabs.org (Postfix) with ESMTP id 3A0ACB7D1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Mar 2010 08:12:20 +1100 (EST)
Received: by iwn35 with SMTP id 35so549586iwn.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Mar 2010 13:12:17 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 11 Mar 2010 14:11:57 -0700
Message-ID: <fa686aa41003111311w2a2c2707yddfe90c953b92be@mail.gmail.com>
Subject: [git pull] driver bug fixes and mpc5200 defconfig updates
To: linuxppc-dev@lists.ozlabs.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	spi-devel-general@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Miller <davem@davemloft.net>, Scott Ellis <scott@jumpnowtek.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Linus,

Here are some driver bug fixes, and the requisite powerpc-mpc5200
defconfig updates.  The defconfig updates would normally go through
Ben's tree, but since that is the only change I have that would go
through his tree I'm hoping that it is okay to have it here.

Cheers,
g.

The following changes since commit 57d54889cd00db2752994b389ba714138652e60c:
  Linus Torvalds (1):
        Linux 2.6.34-rc1

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6 merge

David Miller (1):
      uartlite: Fix build on sparc.

Grant Likely (1):
      powerpc/52xx: update defconfigs

Scott Ellis (2):
      spi/omap2_mcspi: fix NULL pointer dereference
      spi/omap2_mcspi: Use transaction speed if provided

 arch/powerpc/configs/52xx/cm5200_defconfig    |   24 ++--
 arch/powerpc/configs/52xx/lite5200b_defconfig |   28 +++--
 arch/powerpc/configs/52xx/motionpro_defconfig |   25 +++--
 arch/powerpc/configs/52xx/pcm030_defconfig    |   27 +++---
 arch/powerpc/configs/52xx/tqm5200_defconfig   |   28 +++---
 arch/powerpc/configs/mpc5200_defconfig        |  134 ++++++++++++++++---------
 drivers/serial/uartlite.c                     |   10 +-
 drivers/spi/omap2_mcspi.c                     |   18 ++-
 8 files changed, 177 insertions(+), 117 deletions(-)


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
