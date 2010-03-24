Return-Path: <elendil@planet.nl>
Received: from CPSMTPM-EML109.kpnxchange.com (Cpsmtpm-eml109.kpnxchange.com
	[195.121.3.13]) by ozlabs.org (Postfix) with ESMTP id DD774B7CF1
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Mar 2010 04:52:27 +1100 (EST)
From: Frans Pop <elendil@planet.nl>
To: netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 00/09] net: remove trailing spaces in messages
Date: Wed, 24 Mar 2010 18:40:15 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201003241840.18701.elendil@planet.nl>
Cc: Jon Maloy <jon.maloy@ericsson.com>, Samuel Ortiz <samuel@sortiz.org>,
	e1000-devel@lists.sourceforge.net,
	Per Liden <per.liden@ericsson.com>, linuxppc-dev@ozlabs.org,
	Allan Stephens <allan.stephens@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is the second patchset to remove trailing spaces in kernel messages. 
Patches in this set cover networking code, excepting wireless which will be 
submitted in a separate set.

Patches have been rebased against current net-next.

Benefits are:
- general cleanup and consistency
- minor reduction in kernel size and user's log file size
- reduced annoyance for people writing logcheck rules

I have run the patches through checkpatch and included some fixes, but in 
most cases the files are so horrible in general that fixing the warnings 
purely for these changes doesn't make sense.

Shortstat:
 56 files changed, 236 insertions(+), 236 deletions(-)

Frans Pop (9):
      net: remove trailing space in messages
      net/tipc: remove trailing space in messages
      net/irda: remove trailing space in messages
      net/ps3_gelic: remove trailing space in messages
      net/smc91xx: remove trailing space in messages
      net/tokenring: remove trailing space in messages
      net/tulip: remove trailing space in messages
      net/intel: remove trailing space in messages
      net/various: remove trailing space in messages

Cheers,
FJP
