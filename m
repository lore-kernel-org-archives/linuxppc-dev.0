Return-Path: <jrigby@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F30BADDE00
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 09:03:27 +1000 (EST)
From: John Rigby <jrigby@freescale.com>
To: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	jeff@garzik.org, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 0/2] Add MPC5121 FEC suppport
Date: Tue, 17 Jun 2008 17:03:12 -0600
Message-Id: <1213743794-3537-1-git-send-email-jrigby@freescale.com>
Cc: netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Note:  This patch series assumes Kumar's Remove
!CONFIG_PPC_CPM_NEW_BINDING patch has been applied. 
http://patchwork.ozlabs.org/linuxppc/patch?q=kumar&id=18939

Addresses all comments to previous patch.
Split the patch into two parts:

Part 1 fixes all problems reported by checkpatch.pl
and changes instances of fec_t to struct fec.

Part 2 addes 5121 support.  And cleans up the Kconfig
logic based on input from Scott Wood and Sam Ravnborg.
