Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id CB564B7B68
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2009 03:00:01 +1100 (EST)
Date: Mon, 12 Oct 2009 20:00:00 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Miller <davem@davemloft.net>
Subject: [PATCH 0/8] gianfar: Add support for hibernation
Message-ID: <20091012160000.GA32406@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	netdev@vger.kernel.org, Andy Fleming <afleming@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

Here are few patches that add support for hibernation for gianfar
driver.

Technically, we could just do gfar_close() and then gfar_enet_open()
sequence to restore gianfar functionality after hibernation, but
close/open does so many unneeded things (e.g. BDs buffers freeing and
allocation, IRQ freeing and requesting), that I felt it would be much
better to cleanup and refactor some code to make the hibernation [and
not only hibernation] code a little bit prettier.

Patches on the way...

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
