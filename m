Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17197.65270.548340.377011@cargo.ozlabs.ibm.com>
Date: Mon, 19 Sep 2005 09:57:42 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: Git tree for the 32/64 merge
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I have created a git tree on kernel.org as a place to accumulate the
patches for the ppc32/ppc64 merge.  It is at:

rsync://rsync.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc-merge.git

It doesn't include the objects in Linus' tree; instead it has an
objects/info/alternates file pointing to Linus' tree.

This tree contains all the patches I found in a scan through my inbox
that relate to the merge and haven't already gone to Linus.  If you
have a patch that should go in, please resend it.

Paul.
