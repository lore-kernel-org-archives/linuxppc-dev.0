Return-Path: <jrigby@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3C8E6DDFF0
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 03:01:38 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m08G1Yw9013456
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jan 2008 09:01:34 -0700 (MST)
Received: from localhost.localdomain (mvp-10-214-72-80.am.freescale.net
	[10.214.72.80])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m08G1XJG004714
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jan 2008 10:01:34 -0600 (CST)
From: John Rigby <jrigby@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/7] mpc5121 support
Date: Tue,  8 Jan 2008 09:01:26 -0700
Message-Id: <1199808093-15929-1-git-send-email-jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following series adds basic support
for mpc5121.  I'm hoping that this can get reviewed
quickly so it can get into the for-2.6.25 tree.
