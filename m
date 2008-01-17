Return-Path: <linuxppcdev@lists.qbjnet.com>
Date: 17 Jan 2008 22:26:24 -0000
Message-ID: <20080117222624.19372.qmail@kunk.qbjnet.com>
From: linuxppcdev@lists.qbjnet.com
To: Linuxppc-dev@ozlabs.org
Subject: L3CR
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It there a l3cr parameter? It's not in the kernel documentation. I'm
trying to enable L2 and L3 cache on a G4 cpu upgrade board in a powermac.

>From OSX I was able to get the values of:
l2cr = 0x80000000
and
l3cr = 0x9F020300

from a cache config utility. I've seen references to l3cr setting on
bsd lists but not for linux.

Thanks...
