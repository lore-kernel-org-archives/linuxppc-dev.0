Return-Path: <jwboyer@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.184])
	by ozlabs.org (Postfix) with ESMTP id C11EE474C2
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Dec 2008 06:42:15 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id e27so94802nfd.9
	for <linuxppc-dev@ozlabs.org>; Fri, 05 Dec 2008 11:42:12 -0800 (PST)
Date: Fri, 5 Dec 2008 14:42:06 -0500
From: Josh Boyer <jwboyer@gmail.com>
To: paulus@samba.org
Subject: Please pull 'merge' branch of 4xx tree
Message-ID: <20081205194206.GD32621@yoda.jdub.homelinux.org>
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

Please pull the 'merge' branch of the 4xx tree to pick up the fix below.
Once it's in Linus' tree, I'll submit it to -stable as we need the same
fix in .27.

josh

The following changes since commit feaf3848a813a106f163013af6fcf6c4bfec92d9:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://git.kernel.dk/linux-2.6-block

are available in the git repository at:

  ssh://master.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git merge

Grant Likely (1):
      powerpc/virtex5: Fix Virtex5 machine check handling

 arch/powerpc/kernel/cpu_setup_44x.S |    1 +
 arch/powerpc/kernel/cputable.c      |    3 +++
 2 files changed, 4 insertions(+), 0 deletions(-)
