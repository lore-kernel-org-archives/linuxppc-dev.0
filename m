Return-Path: <mikey@neuling.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Neuling <mikey@neuling.org>
Date: Fri, 18 Jan 2008 09:16:07 +1100
Subject: [PATCH] Add crashdump shutdown hooks
In-Reply-To: <15983.1200548209@neuling.org>
Message-Id: <1200608167.508733.302962562869.qpush@coopers>
Cc: linuxppc-dev@ozlabs.org, RAISCH@de.ibm.com,
	Stephen Rothwell <sfr@canb.auug.org.au>, THEMANN@de.ibm.com
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
Updated some comments in the code, as noticed by sfr, Josh Boyer and a
dirty car owner.
