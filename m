Return-Path: <marvin24@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 947A5DDF01
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jul 2008 04:43:13 +1000 (EST)
From: Marvin <marvin24@gmx.de>
To: linuxppc-dev@ozlabs.org
Subject: 32-bit kernel on PPC64 supported?
Date: Fri, 18 Jul 2008 20:43:08 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200807182043.08991.marvin24@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

while trying to cleanup some configs/makefiles for ppc64 I noticed, that 
CONFIG_POWER4 implies CONFIG_PPC64 and vice versa in all defconfigs.
So I want to boldly replace CONFIG_POWER4 by CONFIG_PPC64 - ugh.

However, there are some constructs like:

#ifndef CONFIG_PPC64
...
#ifdef CONFIG_POWER4
...
#endif
...
#endif /* CONFIG_PPC64 */

in which POWER4 is always undefined, e.g. in 
include/asm-powerpc/mmu_context.h. Maybe this is a leftover from times, where 
64-bit kernels where not supported on Powermacs. Is this 32-bit support still 
necessary?

Greetings

Marvin
