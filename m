Return-Path: <arnd@arndb.de>
Message-Id: <20060429011827.502138000@localhost.localdomain>
Date: Sat, 29 Apr 2006 03:18:27 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 0/4] NUMA support for spufs
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The current version of spufs breaks upon boot when NUMA support is enabled.
I'd like to fix that before 2.6.17 so we can use the same kernel image
on Cell that we use on other powerpc systems using NUMA.

This series has four patches, the first two are required to make it work
at all, the other two are there for a somewhat cleaner solution.

The second patch (sparsemem-interaction-with-memory-add-bug-fixes.patch)
actually comes from 2.6.17-rc2-mm1, but in order to make this work,
we need it included in mainline along with the others.

	Arnd <><
--
