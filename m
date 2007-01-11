Return-Path: <michael@ozlabs.org>
To: Greg Kroah-Hartman <greg@kroah.com>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 11 Jan 2007 22:25:16 +1100
Subject: [PATCH 0/7] Powerpc MSI Implementation
Message-Id: <1168514716.63474.857278133999.qpush@cradle>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Olof Johannsson <olof@lixom.net>, linux-pci@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This series implements infrastructure for PCI MSI on Powerpc.

It also includes a "backend" for MSI via HT on the MPIC, and supporting
patches. Other backends are in the works.

I think this is ready to merge for 2.6.21, let me know if you disagree ..
unless your name is Segher :D

Greg, assuming you agree this is OK to merge, is this something you'd
want to take in your tree, or are you happy ack it and have it go into
Paul's tree?

cheers
