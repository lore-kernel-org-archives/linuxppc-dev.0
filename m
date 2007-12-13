Return-Path: <mikey@neuling.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Neuling <mikey@neuling.org>
Date: Thu, 13 Dec 2007 14:16:17 +1100
Subject: [PATCH 0/2] Add crashdump shutdown hooks
In-Reply-To: <20071212054512.A02B062C153@localhost.localdomain>
Message-Id: <1197515777.834799.307108384755.qpush@coopers>
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>,
	RAISCH@de.ibm.com, THEMANN@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following patches add crashdump shutdown hooks for POWERPC.
Signed-off-by: Michael Neuling <mikey@neuling.org>
---

This is an updated series following comments from the first post.
Adds some documentation, better code flow, fixes 32 bit compiles and
other updates based on feedback

Again these are based on paulus' for 2.6.25 tree.
