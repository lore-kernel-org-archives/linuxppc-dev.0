Return-Path: <linas@austin.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 77A1667BAB
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Sep 2006 09:05:56 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e33.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8TN5rX3006649
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Sep 2006 19:05:53 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k8TN5rw3312492
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Sep 2006 17:05:53 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k8TN5qre022081
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Sep 2006 17:05:53 -0600
Date: Fri, 29 Sep 2006 18:05:52 -0500
To: jeff@garzik.org, akpm@osdl.org
Subject: [PATCH 0/6]: powerpc/cell spidernet ethernet patches
Message-ID: <20060929230552.GG6433@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: linas@austin.ibm.com (Linas Vepstas)
Cc: netdev@vger.kernel.org, James K Lewis <jklewis@us.ibm.com>,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Please apply and forward upstream as appropriate.

Although these patches have not been baking in 
any -mm tree, they have been tested and are 
generally available as a part of the Cell SDK 2.0
overseen by Arnd Bergmann. (Arnd, if you want
to lend a voice of authority here, or to correct 
me, please do so...)

The following sequence of six patches implement a 
series of changes to the transmit side of the 
spidernet ethernet device driver, significantly 
improving performance for large packets.

This series of patches is almost identical to 
those previously mailed on 18-20 August, with one
critical change: NAPI polling is used instead of 
homegrown polling.

Although these patches improve things, I am not
satisfied with how this driver behaves, and so 
plan to do additional work next week. 

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Signed-off-by: James K Lewis <jklewis@us.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>

--linas
