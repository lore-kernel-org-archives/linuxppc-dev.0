Return-Path: <jwboyer@gmail.com>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
 [209.85.220.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id D43EFB6F18
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2011 02:14:55 +1100 (EST)
Received: by vcbfl15 with SMTP id fl15so456509vcb.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2011 07:14:52 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 30 Nov 2011 10:14:52 -0500
Message-ID: <CA+5PVA6ahzxWHqBiESw8x7RVC1n8hjqBPvMnQ8qfb=bpwMeuzQ@mail.gmail.com>
Subject: Please pull 'next' branch of new 4xx tree
From: Josh Boyer <jwboyer@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

I have a new 4xx tree setup now.  Two small commits for the next
branch are queued up.  I'd like to get the patch series from Suzie and
Tony included soon as well, but thought I'd start with these to get
things rolling.

Stephen, can you switch the linux-next tree to use this instead?

josh

The following changes since commit fa8cbaaf5a68f62db3f9a8444ecbb940b47984cb:

  powerpc+sparc64/mm: Remove hack in mmap randomize layout (2011-11-28
11:42:09 +1100)

are available in the git repository at:
  git://git.infradead.org/users/jwboyer/powerpc-4xx.git next

Josh Boyer (1):
      MAINTAINERS: Update PowerPC 4xx git tree

Tanmay Inamdar (1):
      powerpc/40x: Add APM8018X SOC support

 MAINTAINERS                                 |    2 +-
 arch/powerpc/boot/dts/klondike.dts          |  227 +++++++++++++++++++++++++++
 arch/powerpc/configs/40x/klondike_defconfig |   55 +++++++
 arch/powerpc/kernel/cputable.c              |   13 ++
 arch/powerpc/platforms/40x/Kconfig          |   11 ++
 arch/powerpc/platforms/40x/ppc40x_simple.c  |    1 +
 6 files changed, 308 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/klondike.dts
 create mode 100644 arch/powerpc/configs/40x/klondike_defconfig
