Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 58CE2DDE48
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 04:01:22 +1100 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id B0C258810
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 21:01:19 +0400 (SAMT)
Date: Tue, 13 Nov 2007 19:58:25 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/3] MPC8323E-RDB now using MMC-over-SPI
Message-ID: <20071113165825.GA23739@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

Here are three well-split patches for the easier review. I can fold
them into one for the merge, if you like.

I've tested the functionality using SD 128MB Kingston (MMC SanDisk
16MB refused to work, but it's definitely not a powerpc issue. Also
I'm not sure that that particular card worked at all ;-).

Patches should apply cleanly on paulus/powerpc.git and/or
galak/powerpc.git, master branches.

Thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
