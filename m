Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 86244DE02D
	for <linuxppc-dev@ozlabs.org>; Mon, 18 May 2009 17:01:11 +1000 (EST)
Subject: fs_enet build breakage
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@gate.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 18 May 2009 17:01:04 +1000
Message-Id: <1242630064.18075.48.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Kumar

Commit 4484079d517c2b6521621be0b1ea246ccc55c7d7 from your next branch
breaks my 8xx test config with the following error:

/home/benh/linux-powerpc-test/drivers/net/fs_enet/fs_enet-main.c: In function ‘setup_immap’:
/home/benh/linux-powerpc-test/drivers/net/fs_enet/fs_enet-main.c:947: error: ‘IMAP_ADDR’ undeclared (first use in this function)
/home/benh/linux-powerpc-test/drivers/net/fs_enet/fs_enet-main.c:947: error: (Each undeclared identifier is reported only once
/home/benh/linux-powerpc-test/drivers/net/fs_enet/fs_enet-main.c:947: error: for each function it appears in.)

I'm still pushing it with a bunch of other stuff to "test" so people get
to find more breakage but it will need to be fixed for the actual "next"
branch.

Cheers,
Ben.
