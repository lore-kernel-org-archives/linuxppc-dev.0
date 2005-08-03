Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17136.13558.773102.465379@cargo.ozlabs.ibm.com>
Date: Wed, 3 Aug 2005 13:07:34 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: Merging ppc32 and ppc64
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

At OLS I discussed the idea of merging the ppc32 and ppc64
architectures in the Linux kernel with various ppc32 and ppc64 kernel
hackers and users.  There was broad agreement that this would be a
good thing to do, so we are going to go ahead and do it.

The plan is to create include/asm-powerpc and arch/powerpc directories
for the merged architecture and move stuff in there as it gets
merged.  The existing ppc32 and ppc64 directories will stay around
until they are no longer useful.  The intention is not to break
anything that currently works; however, we do not plan to move unused
and unmaintained platforms into the merged architecture.

The advantage of merging is that it will reduce the maintenance effort
and reduce the instances where a common bug gets fixed in one
architecture but not the other.  It will also make it easier to
support 64-bit embedded systems as they become more common.

I don't see the merge as changing the actual code that gets executed
on any given platform very much, except in one respect: we are going
to standardize on a flattened device tree as the way that information
about the platform gets passed from the boot loader to the kernel.

Comments? Flames? :)

Paul.
