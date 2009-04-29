Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id 2D9FBDDEF3
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2009 13:58:27 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so543966yxb.39
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 20:58:25 -0700 (PDT)
MIME-Version: 1.0
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 28 Apr 2009 21:58:05 -0600
Message-ID: <fa686aa40904282058l64fbcc7cp5ea3521951bd6b9c@mail.gmail.com>
Subject: Please pull merge branch
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>, John Linn <John.Linn@xilinx.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul/Ben,

Here is a bug fix, a minor tweak and a tidy to merge for 2.6.30.
Please pull 'merge' branch of git://git.secretlab.ca/git/linux-2.6

Thanks,
g.

The following changes since commit 56a50adda49b2020156616c4eb15353e0f9ad7de:
  Linus Torvalds (1):
        Merge branch 'drm-intel-next' of
git://git.kernel.org/.../anholt/drm-intel

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6 merge

Grant Likely (2):
      powerpc: Update MPC5xxx and Xilinx Virtex maintainer entries
      powerpc/virtex: Add uImage to the default images list

John Linn (1):
      powerpc/virtex: Fix duplicate level irq events.

 MAINTAINERS                        |    4 +-
 arch/powerpc/platforms/40x/Kconfig |    1 +
 arch/powerpc/platforms/44x/Kconfig |    1 +
 arch/powerpc/sysdev/xilinx_intc.c  |  117 ++++++++++++++++++++++++++++++++---
 4 files changed, 111 insertions(+), 12 deletions(-)


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
