Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id 7A520DE1FA
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Apr 2008 00:00:41 +1000 (EST)
Subject: HR timers on PowerPC 83xx
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: 'linuxppc-dev Development' <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Fri, 25 Apr 2008 16:00:39 +0200
Message-Id: <1209132039.31117.17.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Trying to understand what is needed to make nanosleep() and friends to
have better resolution than HZ on my 83xx CPU. Is this possible
and what CONFIG options do I need to enable? Kernel is 2.6.25

   Jocke
