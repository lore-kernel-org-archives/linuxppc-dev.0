Return-Path: <mikey@neuling.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6284ADDDF6
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2009 17:27:04 +1000 (EST)
To: Michael Neuling <mikey@neuling.org>, Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Neuling <mikey@neuling.org>
Date: Wed, 29 Apr 2009 17:27:03 +1000
Subject: [PATCH 0/2] powerpc: tlbie implementation for PowerPC ISA 2.06
In-Reply-To: <1240989640.548113.69052602556.qpush@pale>
Message-Id: <1240990023.559815.441622408876.qpush@pale>
Cc: linuxppc-dev@ozlabs.org, Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

These patches implement the PowerPC ISA 2.06 tlbie mnemonics

Signed-off-by: Michael Neuling <mikey@neuling.org>
--- 
Built ontop of ppc-opcode cleanup patches
Renamed somethings to be more logical based on comments from mpe.
