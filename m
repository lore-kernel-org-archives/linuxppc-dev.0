Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Add valgrind support to testsuite 
In-Reply-To: Your message of "Wed, 21 Nov 2007 11:56:14 +1100."
	<20071121005614.GD13156@localhost.localdomain>
References: <20071121005614.GD13156@localhost.localdomain> 
Date: Mon, 26 Nov 2007 16:10:39 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IwmA3-0002eh-OO@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day David Gibson mumbled:
> This patch adds some options to the run_tests.sh script allowing it to
> run all the testcases under valgrind to check for pointer corruption
> bugs and memory leaks.  Invoking "make checkm" will run the testsuite
> with valgrind.
> 
> It include a mechanism for specifying valgrind errors to be suppressed
> on a per-testcase basis, and adds a couple of such suppression files
> for the mangle-layout and open_pack testcases which dump for use by
> other testcases a buffer which may contain uninitialized sections.  We
> use suppressions rather than initializing the buffer so that valgrind
> will catch any internal access s to the uninitialized data, which
> would be a bug.
> 
> The patch also fixes one genuine bug caught by valgrind -
> _packblocks() in fdt_rw.c was using memcpy() where it should have been
> using memmove().
> 
> At present the valgrinding won't do anything useful for testcases
> invoked via a shell script - which includes all the dtc testcases.  I
> plan to fix that later.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

Thanks,
jdl

PS -- Clearly, I'm going to have to break down and install valgrind now. :-)
