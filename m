Return-Path: <mikey@neuling.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7E27BDE001
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2009 10:26:20 +1000 (EST)
To: Michael Neuling <mikey@neuling.org>, Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Neuling <mikey@neuling.org>
Date: Wed, 29 Apr 2009 10:26:19 +1000
Subject: [PATCH 0/2] powerpc: tlbie implementation for PowerPC ISA 2.06
In-Reply-To: <1530CE92-A052-487F-B5D1-643E166068B6@kernel.crashing.org>
Message-Id: <1240964779.937446.557363311774.qpush@pale>
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
Moves MMU_FTR_TLBIE_206 down one bit as the item before has now been
removed.  Thanks to Kumar for noticing. 
