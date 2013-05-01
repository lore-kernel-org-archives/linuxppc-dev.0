Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 0/3] powerpc: Context switch Event Based Branch (EBB) SPRs
Date: Wed,  1 May 2013 16:17:01 +1000
Message-Id: <1367389024-20391-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Event Based Branching (EBB) is a new POWER8 feature to take asynchronous
userspace interrupt based on events.  Currently on POWER8 these events can be
PMU overflows.

This patch series context switches the three new EBB SPRs which are:
- Event Based Branch Handler Register (EBBHR)
- Event Based Branch Return Register (EBBRR)
- Branch Event Status And Control Register (BESCR)

Context switching these ensures there's no covert channel between processes.

This series developed by the BML team.

Apologies that the new EBB SPR acronyms are not humorously named.  Our powerpc
architects had an off day.

Mikey
