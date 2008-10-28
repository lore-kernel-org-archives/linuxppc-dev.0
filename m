Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 28 Oct 2008 16:48:15 +1100
Subject: [PATCH 0/10] powerpc/pci: Fix PCI Hotplug
Message-Id: <1225172895.217185.958686212130.qpush@grosgo>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This series of patches is aimed at fixing all sort of issues
with the PCI hotplug support on pSeries. The meant is in the
second to last patch, but it relies on a whole bunch of small
changes to separate the bus fixup operation in two that are
needed to fix the root of most problems.

Please review/test asap as I would like that in 2.6.28 despite
being a bit late, as without these, PCI hotplug on pseries pretty
much doesn't work. It should also make it easier in the future to
implement hotplug support on other platforms.
