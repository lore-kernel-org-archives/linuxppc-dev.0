Return-Path: <benh@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 465762C0087
 for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2013 17:13:35 +1100 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@au1.ibm.com>;
 Thu, 3 Jan 2013 16:10:32 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id EE06A2BB004A
 for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2013 17:13:30 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r0361xBi31588592
 for <linuxppc-dev@ozlabs.org>; Thu, 3 Jan 2013 17:01:59 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r036DUbB025113
 for <linuxppc-dev@ozlabs.org>; Thu, 3 Jan 2013 17:13:30 +1100
Message-ID: <1357193608.3924.37.camel@pasglop>
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 03 Jan 2013 17:13:28 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
 Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Linus !

Here are a couple of small powerpc fixes. They aren't new bugs (and
they are both CCed to stable) but I didn't see the point of sitting
on the fixes any longer.

Oh and happy new year !

Cheers,
Ben.

The following changes since commit d1c3ed669a2d452cacfb48c2d171a1f364dae2ed:

  Linux 3.8-rc2 (2013-01-02 18:13:21 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git 

for you to fetch changes up to e6449c9b2d90c1bd9a5985bf05ddebfd1631cd6b:

  powerpc: Add missing NULL terminator to avoid boot panic on PPC40x (2013-01-03 16:45:52 +1100)

----------------------------------------------------------------
Gabor Juhos (1):
      powerpc: Add missing NULL terminator to avoid boot panic on PPC40x

Shan Hai (1):
      powerpc/vdso: Remove redundant locking in update_vsyscall_tz()

 arch/powerpc/kernel/time.c                 |    5 -----
 arch/powerpc/platforms/40x/ppc40x_simple.c |    3 ++-
 2 files changed, 2 insertions(+), 6 deletions(-)
