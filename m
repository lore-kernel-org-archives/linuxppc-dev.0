Return-Path: <adolnikov@ru.mvista.com>
Received: from barber.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EF470DDE20
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Nov 2007 03:05:19 +1100 (EST)
Received: from barber.spb.rtsoft.ru (localhost.localdomain [127.0.0.1])
	by barber.spb.rtsoft.ru (8.13.1/8.13.1) with ESMTP id lAGFhif4025075
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Nov 2007 18:43:44 +0300
Received: (from root@localhost)
	by barber.spb.rtsoft.ru (8.13.1/8.13.1/Submit) id lAGFhit8025074
	for linuxppc-dev@ozlabs.org; Fri, 16 Nov 2007 18:43:44 +0300
Date: Fri, 16 Nov 2007 18:43:44 +0300
From: Andrei Dolnikov <adolnikov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/1] PowerPC 74xx: Add Emerson Katana Qp support
Message-ID: <20071116154344.GA25062@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello folks,

The following patch sequence is intended to add support for the Emerson
Katana Qp ATCA board based on MPC7448 CPU and Marvell 64460 chipset.
The patches are incremental to minor mv64x60 code fixups sent by
Mark A. Greer on 11/08/07.

Thanks,
Andrei.
