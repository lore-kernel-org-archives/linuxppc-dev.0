Return-Path: <mikey@neuling.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DB07FDDE23
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 16:58:01 +1000 (EST)
To: Michael Neuling <mikey@neuling.org>, Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Neuling <mikey@neuling.org>
Date: Thu, 30 Apr 2009 16:58:01 +1000
Subject: [PATCH 0/4] powerpc: tlbie implementation for PowerPC ISA 2.06 and
	cleanups for ppc-opcode.h
In-Reply-To: <23749.1241051084@neuling.org>
Message-Id: <1241074681.528764.881549582503.qpush@pale>
Cc: linuxppc-dev@ozlabs.org, Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

These patches implement the tlbie instruction for PowerPC ISA 2.06 and a few cleanups for ppc-opcode.h

Signed-off-by: Michael Neuling <mikey@neuling.org>
--- 
Fixed coding style for moved VSX instructions.  
Correctly alphabetized the newly added instructions.
