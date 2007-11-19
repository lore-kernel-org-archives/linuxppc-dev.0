Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 19 Nov 2007 19:25:00 +1100
Subject: [RFC/PATCH 0/9] powerpc: 4xx PCI work in progress
Message-Id: <1195460700.350036.781662541765.qpush@grosgo>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Because a mailing list is the best of backups and I've get something
working allright on ebony right now, I figured I would post my WIP
pile of patch bringing PCI to the 44x arch/powerpc world.

At this stage, only ebony is hooked up, there's a known problem with
the SCSI layer and non-coherent architecture that causes random
corruption for which I'm trying to find a solution, and e1000 has a
problem with resources > 32 bits for which I have a separate patch.
