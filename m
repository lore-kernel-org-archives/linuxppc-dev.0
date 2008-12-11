Return-Path: <jwboyer@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.28])
	by ozlabs.org (Postfix) with ESMTP id BB60ADDEF5
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 23:41:46 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so407885yxg.39
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 04:41:44 -0800 (PST)
Sender: Josh Boyer <jwboyer@gmail.com>
Date: Thu, 11 Dec 2008 07:41:28 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: Please pull 'merge' branch of 4xx tree
Message-ID: <20081211124128.GA2780@yoda.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,

I have one more small fix for 2.6.28 in my merge branch.  It fixes
an assembler error with some toolchains, notably ELDK.  I've CC'd
Linus in case you don't have anything else pending at the moment.

josh

The following changes since commit ab44f4627e2160cddbddbe8aa8b1d2b2e1559790:
  Paul Mackerras (1):
        Merge branch 'merge' of master.kernel.org:/.../galak/powerpc into merge

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git merge

Josh Boyer (1):
      powerpc/40x: Add proper BOOTCFLAGS for cuboot-acadia

 arch/powerpc/boot/Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)
