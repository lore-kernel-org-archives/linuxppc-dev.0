Return-Path: <raphael.bossek@gmx.de>
Received: from frolch.speech-design.de (frolch.speech-design.de
	[213.69.58.201]) by ozlabs.org (Postfix) with ESMTP id 4AB7767D12
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Jul 2005 19:26:14 +1000 (EST)
Message-ID: <42E0B826.2070800@gmx.de>
Date: Fri, 22 Jul 2005 11:11:02 +0200
From: Raphael Bossek <raphael.bossek@gmx.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: debian-embedded@lists.debian.org
Subject: Experiences with Debian Sarge on MPC8xx ?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

Debian GNU/Linux v3.1 (Sarge) is out so give it a try on my MPC850
running Debian v3.0 for more then 1 year with Denx's 2.4.20 kernel.

It failed with more or less the same reason as described May 2004
in this posting 
http://lists.debian.org/debian-embedded/2004/05/msg00032.html

Things changed since May 2004 but the problem seams to be. I'm using
100% binary compatible Debian GNU/Linux 3.0 (Woody) without any
problems on my MPC860 board with kernel FPU emulation enabled. This
math-emu implementation seams to be stable enought to work with libc6
2.2.5 and very many server application and large C++ application at high
load (our stress tests are really horrible for the compleate system!).

I've also heard from people on IRC that 100% Sarge works for them on
FPU-less MPC boards without trouble. So while I'm investigating the
problem would like to hear some more respond on this issue from
people who spend more time on getting Sarge running with 100% Debian
v3.1 (Sarge) on their MPC8xx environment.

The -msoft-float advice is not what I'm looking for. I'm not sure if
the FPU is responsible for the problem. Maybe the Debian libc6 2.3.2
package is missing something important for the MPC8xx PowerPC (the
cache-line-size is 4 for Debian's libc on PowerPC by default). The
big advantage using a standard distribution is the big number of
precompiled packages. I do not intent to recompile more then 18000
due to this first failed tests.

-- 
Raphael Bossek
