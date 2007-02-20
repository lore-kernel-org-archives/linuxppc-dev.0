Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>,
	<cbe-oss-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 20 Feb 2007 18:44:12 +1100
Subject: [PATCH 0/5] Support 64K pages mapping of SPE local stores on 4K
	kernel
Message-Id: <1171957452.861958.803775545202.qpush@grosgo>
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This serie of patches supports userland mappings of SPE local stores
using 64K hardware pages rather than 4K on a kernel using 4K pages to
improve performances.

The current version of this serie relies on a hack to the generic code
which is probably not acceptable upsteam. I have plans to do a proper
fix but haven't had time to do it yet.

The first patch of the serie is fairly independant of the rest and
should be applied to 2.6.21 as I beleive it fixes a bug with handling
of huge pages from SPEs.
