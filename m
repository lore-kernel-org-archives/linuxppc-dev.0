Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3953FDE08A
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 04:22:30 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l4TIMQiX005432
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 11:22:26 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l4TIMPjn022935
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 13:22:25 -0500 (CDT)
Subject: [PATCH 0/3] Fix PCI-E Resource allocation problems on 8641.
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1180462945.13106.56.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Tue, 29 May 2007 13:22:25 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul,

These three patches fix some PCI resource allocation problems
that we saw on 8641 boards.  These patches are on top of
Zhang Wei's earlier 5 patches, and should apply to your
current master branch.

Thanks,
jdl
