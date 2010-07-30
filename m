Return-Path: <matt@ozlabs.org>
Message-ID: <4C5258C8.1030305@ozlabs.org>
Date: Fri, 30 Jul 2010 14:44:56 +1000
From: Matt Evans <matt@ozlabs.org>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, kexec@lists.infradead.org
Subject: [PATCH 0/2] powerpc/kexec: Fix orphaned offline CPUs,
	add comments/debug
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael Neuling <mikey@neuling.org>, Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Separated tidyup comments & debug away from the fix of restarting offline
available CPUs before waiting for them on kexec.


Matt Evans (2):
  powerpc/kexec: Add to and tidy debug/comments in machine_kexec64.c
  powerpc/kexec: Fix orphaned offline CPUs across kexec

 arch/powerpc/kernel/machine_kexec_64.c |   55 ++++++++++++++++++++++++++++---
 1 files changed, 49 insertions(+), 6 deletions(-)
