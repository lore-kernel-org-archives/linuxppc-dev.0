Return-Path: <jwboyer@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.24])
	by ozlabs.org (Postfix) with ESMTP id A9E7FDE1BF
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2009 23:27:14 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 3so842754qwe.15
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2009 06:27:12 -0700 (PDT)
Date: Fri, 24 Apr 2009 09:21:32 -0400
From: Josh Boyer <jwboyer@gmail.com>
To: paulus@samba.org, benh@kernel.crashing.org
Subject: Please pull 'merge' branch of the 4xx tree
Message-ID: <20090424132132.GC2953@yoda.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,

Please pull the following two commits for 2.6.30.  One is a
trivial MAINTAINERS fix, the other fixes a bug that computes
the memory size of some 4xx boards incorrectly.

The following changes since commit 6329db8bd60fbc0832f30c350b0181b8d865573e:
  Bartlomiej Zolnierkiewicz (1):
        powerpc: Fix modular build of ide-pmac when mediabay is built in

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git merge

Josh Boyer (1):
      maintainers: Fix PowerPC 4xx git tree

Valentine Barshak (1):
      powerpc/44x: Correct memory size calculation for denali-based boards

 MAINTAINERS             |    2 +-
 arch/powerpc/boot/4xx.c |   56 ++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 44 insertions(+), 14 deletions(-)


josh
