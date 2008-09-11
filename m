Return-Path: <sebastien.dugue@bull.net>
Received: from ecfrec.frec.bull.fr (ecfrec.frec.bull.fr [129.183.4.8])
	by ozlabs.org (Postfix) with ESMTP id 8F002DDF51
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Sep 2008 23:34:54 +1000 (EST)
From: Sebastien Dugue <sebastien.dugue@bull.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/2] powerpc - EHEA fixes
Date: Thu, 11 Sep 2008 15:34:38 +0200
Message-Id: <1221140080-9853-1-git-send-email-sebastien.dugue@bull.net>
Cc: tklein@de.ibm.com, tinytim@us.ibm.com, jeff@garzik.org, themann@de.ibm.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	jean-pierre.dion@bull.net, sebastien.dugue@bull.net,
	raisch@de.ibm.com, gilles.carry@ext.bull.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


  Hi,

  here are 2 fixes for the ehea driver (nothing urgent here):

  - fix a typo which prevents building when DEBUG is #defined
  - fix mutex and spinlock usage in ehea_main

  and the diffstat for the patchset:

 drivers/net/ehea/ehea_main.c |   26 ++++----------------------
 drivers/net/ehea/ehea_phyp.c |    2 +-
 2 files changed, 5 insertions(+), 23 deletions(-)

  Thanks,

  Sebastien.
