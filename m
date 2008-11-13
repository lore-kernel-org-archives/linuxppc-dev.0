Return-Path: <jwboyer@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.27])
	by ozlabs.org (Postfix) with ESMTP id 87F0EDDE03
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Nov 2008 02:36:29 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so588599qwb.15
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2008 07:36:28 -0800 (PST)
Date: Thu, 13 Nov 2008 10:36:23 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: Please pull 'merge' branch of powerpc-4xx git tree
Message-ID: <20081113153623.GA2299@yoda.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Josh Boyer <jwboyer@gmail.com>
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

Please pull the merge branch of the powerpc-4xx git tree.  It contains
two small fixes that should go into .28.

thx,
josh

The following changes since commit cb8fdc69a2a80e81e1280ec58afd2c3217ac8a7f:
  Paul Mackerras (1):
        powerpc: Update desktop/server defconfigs

are available in the git repository at:

  ssh://master.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git merge

Benjamin Herrenschmidt (1):
      powerpc/44x: Fix 460EX/460GT machine check handling

Grant Erickson (1):
      powerpc/40x: Limit allocable DRAM during early mapping

 arch/powerpc/kernel/cpu_setup_44x.S |    7 ++++++-
 arch/powerpc/mm/40x_mmu.c           |   16 ++++++++++++++--
 2 files changed, 20 insertions(+), 3 deletions(-)
