Return-Path: <rvinson@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 5705CDDED3
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jul 2007 04:56:17 +1000 (EST)
Message-ID: <46A1054D.9070109@mvista.com>
Date: Fri, 20 Jul 2007 11:56:13 -0700
From: Randy Vinson <rvinson@mvista.com>
MIME-Version: 1.0
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 0/6] 85xxCDS: MPC8548CDS Updates and Bug Fixes
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Greetings,
  This patch series contains updates to the MPC8548CDS DTS
and fixes several PCI-related bugs. I'm not 100% sure the
DTS changes are in the proper form, so I'd appreciate any
corrections. Note that some of these patches have been
posted previously.

These patches are based on Kumar's for_paulus branch.

Thanks,
Randy Vinson
