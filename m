Return-Path: <mikey@neuling.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 70EFDDDE0E
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 22:45:03 +1000 (EST)
To: Michael Neuling <mikey@neuling.org>, Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Neuling <mikey@neuling.org>
Date: Tue, 28 Apr 2009 22:45:02 +1000
Subject: [PATCH 0/2] powerpc: tlbie implementation for PowerPC ISA 2.06
In-Reply-To: <B5DD5BF4-8EFF-472F-9D96-DE2941AAD70B@kernel.crashing.org>
Message-Id: <1240922702.557324.191572776427.qpush@pale>
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
This version attempts to address issues raised by Kumar.
- Add missing mmu.h
- Follow the bouncing ball in ppc-opcode.h for #define PPC_TLBIE 
