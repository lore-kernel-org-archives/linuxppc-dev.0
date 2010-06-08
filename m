Return-Path: <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Peter Zijlstra <peterz@infradead.org>
From: Michael Neuling <mikey@neuling.org>
Date: Tue, 08 Jun 2010 14:57:02 +1000
Subject: [PATCH 0/3] sched: asymmetrical packing for POWER7 SMT4
Message-Id: <1275973022.91203.586435002889.qpush@pale>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series implements asymmetric SMT packing which ensures
consistently good performance on POWER7.  Without this series, tasks
will vary in performance by around +/-30% on POWER7

This new version is based on help from Vatsa and Vaidy in an attempt
to answer concerns that Peter Zijlstra had about the original series.

The 1st patch is a fix for SMT4 in general.
The 2nd adds actual the asymmetrical packing infrastructure.  
The 3rd adds the powerpc specific hooks for POWER7.
