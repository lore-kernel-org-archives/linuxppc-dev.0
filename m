Return-Path: <jrigby@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 13B20DE2E2
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Oct 2008 06:01:13 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m97J0j6Q004435
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Oct 2008 12:00:46 -0700 (MST)
From: John Rigby <jrigby@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/3] MPC5121 add pci support
Date: Tue,  7 Oct 2008 13:00:17 -0600
Message-Id: <1223406020-12278-1-git-send-email-jrigby@freescale.com>
Cc: John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following three patches add pci support for MPC5121
These got no NACKs back in August but they were not picked up
by anyone either.
