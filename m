Return-Path: <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <michael@ellerman.id.au>
From: Michael Neuling <mikey@neuling.org>
Date: Thu, 14 Jun 2012 16:15:36 +1000
Subject: [PATCH 0/18] powerpc: convert GPR usage to %r0-31 and R0-31
In-Reply-To: <m2y5nwn7s0.fsf@linux-m68k.org>
Message-Id: <1339654536.159274.140684871779.qpush@ale>
Cc: mikey@neuling.org, linuxppc-dev@ozlabs.org, schwab@linux-m68k.org,
 Anton Blanchard <anton@samba.org>, Olof Johannsson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

First 5 patches convert us to %r0-31.

Next 12 convert make using R0-31 required in macros.

Last 2 convert instructions where ra = r0 we use 0 rather than the
register value (as suggested by Andreas).

Version 2 adds:
  ra = 0 idea (as Andreas suggested)
  Fixes for 32bit KVM (added ppc44x_defconfig to my testing)
  Based on mpe's next tree which has Antons power7 copy patches which
    needed fixes for this
