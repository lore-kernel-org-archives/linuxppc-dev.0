Return-Path: <linas@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DD14ADDF14
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 11:58:27 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1G0wOiM021611
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 19:58:24 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1G0wOLf442594
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 17:58:24 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1G0wNWf016473
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 17:58:24 -0700
Date: Thu, 15 Feb 2007 18:58:23 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 12/12]: spidernet: maintainership
Message-ID: <20070216005823.GL8192@austin.ibm.com>
References: <200701260724.l0Q7OISY027645@toshiba.co.jp>
	<45D3EAA7.80805@garzik.org>
	<1171525923.20192.243.camel@localhost.localdomain>
	<200702151141.49708.jens@de.ibm.com>
	<20070215171414.GU923@austin.ibm.com>
	<1171572392.5644.15.camel@localhost.localdomain>
	<20070216001857.GC923@austin.ibm.com>
	<20070216004325.GA8192@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070216004325.GA8192@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: arnd@arndb.de, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Provisionally change maintinership.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: Jens Osterkamp <Jens.Osterkamp@de.ibm.com>
Cc: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>

----
 MAINTAINERS |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.20-git4/MAINTAINERS
===================================================================
--- linux-2.6.20-git4.orig/MAINTAINERS	2007-02-15 17:27:39.000000000 -0600
+++ linux-2.6.20-git4/MAINTAINERS	2007-02-15 18:01:42.000000000 -0600
@@ -3119,8 +3119,8 @@ L:	linux-kernel@vger.kernel.org ?
 S:	Supported
 
 SPIDERNET NETWORK DRIVER for CELL
-P:	Jim Lewis
-M:	jim@jklewis.com
+P:	Linas Vepstas
+M:	linas@austin.ibm.com
 L:	netdev@vger.kernel.org
 S:	Supported
 
