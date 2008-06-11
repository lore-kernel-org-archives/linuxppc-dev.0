Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id F00F3DDF33
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 09:02:53 +1000 (EST)
Date: Thu, 12 Jun 2008 03:02:51 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 0/4] Fix RTC for MPC8572DS and support RTC on MPC8610HPCD
Message-ID: <20080611230250.GA13412@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Kumar,

The previous series scattered a bit, so I gathered it again.

I've found MPC8572DS board to test RTC quirk changes that I've made
for MPC8610HPCD, and it appears that without the change RTC does not
work on MPC8572DS, too.

So, the first patch actually fixes it for MPC8572DS, and also makes
RTC work on MPC8610HPCD. I still can't test the patch on MPC8641HPCD
and MPC8544DS (no boards handy), but I don't believe that the change
could break these boards.

I also dropped MACH_PCI_FIXUP_*() approach, and did just machine_is()s
inside the fixups. I think this looks better... as far as possible for
the board specific fixups. :-)

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
