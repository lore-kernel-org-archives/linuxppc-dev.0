Return-Path: <mikey@neuling.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Neuling <mikey@neuling.org>
Date: Thu, 13 Dec 2007 20:59:17 +1100
Subject: [PATCH 0/2] Add crashdump shutdown hooks
In-Reply-To: <20071213051224.GA22378@lixom.net>
Message-Id: <1197539957.623622.326790809699.qpush@coopers>
Cc: linuxppc-dev@ozlabs.org, RAISCH@de.ibm.com, THEMANN@de.ibm.com
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
Fixes stupid variable name noticed by Olof.
