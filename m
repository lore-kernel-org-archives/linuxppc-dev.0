Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17250.8725.358204.62510@cargo.ozlabs.ibm.com>
Date: Fri, 28 Oct 2005 23:05:25 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: Patches for 2.6.15
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If anyone has patches for arch/ppc{,64} and include/asm-ppc{,64} that
they would like to see go upstream now that 2.6.14 is out, other than
patches that are already in the powerpc-merge tree, please let me
know.  I am planning to ask Linus to pull the powerpc-merge tree
shortly, and that will probably break your patches.

I think the merge tree is looking pretty good, although the merge is
by no means complete yet.  The powermac, pseries and iseries platforms
seem to be working fine with ARCH=powerpc.  32-bit chrp is mostly
there but needs a bit more work.

If possible, I'd like to get to the point where we can remove
arch/ppc64 entirely by the end of the 2-week merge window for 2.6.15.

Paul.
