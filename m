Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0179868166
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Aug 2005 14:58:49 +1000 (EST)
Date: Tue, 30 Aug 2005 21:58:47 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Jeff Garzik <jgarzik@pobox.com>
Message-ID: <20050831045847.GA17017@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH 0/2] New PowerPC 4xx on-chip ethernet controller driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Jeff,

the following patches replace current PowerPC 4xx EMAC driver with 
new, re-written version.

New driver uses NAPI, it solves problems under heavy packet load and 
low memory, corrects chip register access and fixes numerous small 
bugs I don't even remember now :).

This patch has been tested on all supported in 2.6 PPC 4xx boards. 
It's been used in production for almost a year now on custom 
4xx hardware. PPC32 specific parts were just posted to linuxppc-dev 
and linuxppc-embedded mail lists.

Patch was acked by the current EMAC driver maintainer (Matt Porter). I 
will be maintaining this new version.

Signed-off-by: Eugene Surovegin <ebs@ebshome.net>
