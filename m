Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 4ED54B70A9
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Nov 2010 06:36:33 +1100 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: linuxppc-dev@ozlabs.org
Subject: ppc_set_hwdebug vs ptrace_set_debugreg
Date: Sat, 27 Nov 2010 20:36:30 +0100
Message-ID: <m2lj4ezhhd.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dave Kleikamp <shaggy@linux.vnet.ibm.com>,
	"K.Prasad" <prasad@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Why does ptrace_set_debugreg call register_user_hw_breakpoint, but
ppc_set_hwdebug doesn't?  Shouldn't ppc_set_hwdebug set the
DABR_DATA_(READ|WRITE|TRANSLATION) bits in the dabr?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
