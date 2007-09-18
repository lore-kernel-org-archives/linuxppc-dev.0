Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B3E07DDE3D
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 03:26:25 +1000 (EST)
Received: from vaxon.spb.rtsoft.ru (localhost.localdomain [127.0.0.1])
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1) with ESMTP id l8IHPAbS031065
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2007 21:25:10 +0400
Received: (from vaxon@localhost)
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1/Submit) id l8IHPACY031062
	for linuxppc-dev@ozlabs.org; Tue, 18 Sep 2007 21:25:10 +0400
Date: Tue, 18 Sep 2007 21:25:10 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/2] PowerPC: Fix MAL0 DTS entries for Bamboo and Sequoia.
Message-ID: <20070918172510.GA30944@ru.mvista.com>
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

A couple of minor fixes to correct MAL0 DTS entries for bamboo.dts and sequoia.dts.
Also correct MAL channel assignment for EMACs on Sequoia board.
