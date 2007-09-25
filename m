Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 0B563DDE0D
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 00:29:37 +1000 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id 35FD68810
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 19:29:35 +0500 (SAMST)
Date: Tue, 25 Sep 2007 18:31:26 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: MPC85xx_MDS: Patches to support QE, UCCs and SPI
Message-ID: <20070925143126.GA30013@localhost.localdomain>
MIME-Version: 1.0
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

These patches needed to make QE, UCCs and SPI work on MPC8568E-MDS.

Patchset is against galak/powerpc.git master branch.

Thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
