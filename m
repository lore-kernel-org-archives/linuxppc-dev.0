Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) by ozlabs.org (Postfix) with ESMTP id CA91FB70D0
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  3 Oct 2010 15:10:23 +1100 (EST)
Received: by iwn4 with SMTP id 4so5770392iwn.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 02 Oct 2010 21:10:20 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 2 Oct 2010 22:10:00 -0600
Message-ID: <AANLkTi=epb2ees2gy2_y=VOe-dBR8h4rGQC1HvUPZxYG@mail.gmail.com>
Subject: [git pull] MPC5xxx powerpc fixes
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linuxppc-dev@lists.ozlabs.org, Akinobu Mita <akinobu.mita@gmail.com>,
	Eric Millbrandt <emillbrandt@dekaresearch.com>,
	Julia Lawall <julia@diku.dk>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben and Linus

Here are some powerpc fixes that I had sitting in my tree and forgot
about.  They are ready to be merged, and are for the mpc5xxx platform
that I maintain, but Ben hasn't acked them yet.  Ben, do you want
Linus to pull this directly, or do you have other powerpc commits that
you want to merge it with before Linus picks it up?

Thanks,
g.

The following changes since commit 899611ee7d373e5eeda08e9a8632684e1ebbbf00:
  Linus Torvalds (1):
        Linux 2.6.36-rc6

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6 merge-powerpc

Akinobu Mita (1):
      powerpc/512x: fix clk_get() return value

Eric Millbrandt (1):
      powerpc/5200: tighten up ac97 reset timing

Julia Lawall (1):
      powerpc/5200: efika.c: Add of_node_put to avoid memory leak

 arch/powerpc/platforms/512x/clock.c          |    2 +-
 arch/powerpc/platforms/52xx/efika.c          |    9 ++++++---
 arch/powerpc/platforms/52xx/mpc52xx_common.c |    8 ++++++--
 3 files changed, 13 insertions(+), 6 deletions(-)


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
