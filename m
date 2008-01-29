Return-Path: <dwm@austin.ibm.com>
Received: from willy.enoyolf.org (willy.enoyolf.org [24.173.215.188])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "willy.enoyolf.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1C5B9DDE00
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jan 2008 18:48:41 +1100 (EST)
From: Doug Maxey <dwm@austin.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/5] ehea: fixups for checkpatch
Date: Tue, 29 Jan 2008 00:50:54 -0600
Message-Id: <1201589459-30598-1-git-send-email-dwm@austin.ibm.com>
Cc: Jan-Bernd Themann <themann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


A set of fixups that silences checkpatch.

++doug
---
 drivers/net/ehea/ehea.h         |    3 +
 drivers/net/ehea/ehea_ethtool.c |    4 +-
 drivers/net/ehea/ehea_hw.h      |    8 +-
 drivers/net/ehea/ehea_main.c    |   87 +++++++++++----------
 drivers/net/ehea/ehea_phyp.c    |  158 +++++++++++++++++++-------------------
 drivers/net/ehea/ehea_phyp.h    |   22 +++---
 drivers/net/ehea/ehea_qmr.c     |   32 ++++----
 drivers/net/ehea/ehea_qmr.h     |   16 ++--
 8 files changed, 169 insertions(+), 161 deletions(-)
