Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17274.51251.591579.8751@cargo.ozlabs.ibm.com>
Date: Wed, 16 Nov 2005 16:48:35 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org, akpm@osdl.org
Subject: powerpc.git tree now on kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I have just created a git tree for ppc/powerpc patches that are
candidates for 2.6.16.  The tree is at:

git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git

Currently, besides the patches that are in the powerpc-merge.git tree,
there are the following patches in there:

Adrian Bunk:
      PPC_PREP: remove unneeded exports

Benjamin Herrenschmidt:
      powerpc: Merge align.c (#2)

David Gibson:
      powerpc: Remove imalloc.h

David Woodhouse:
      syscall entry/exit revamp

Kumar Gala:
      powerpc: moved ipic code to arch/powerpc

Michael Ellerman:
      powerpc: Merge kexec

Mike Kravetz:
      Remove SPAN_OTHER_NODES config definition

Although some of these patches may go to Linus before 2.6.15 is
released, I won't be asking Linus to pull this tree directly, since it
is likely to get a bit messy as patches are updated.  I expect that
Andrew Morton will pull this tree periodically and include it in his
-mm releases.

Paul.
