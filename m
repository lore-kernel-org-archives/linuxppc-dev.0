Return-Path: <linas@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E28AC67CC6
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Dec 2006 09:32:27 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e35.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kB6MWOhS017143
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Dec 2006 17:32:24 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kB6MWO9D398582
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Dec 2006 15:32:24 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kB6MWN6g009187
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Dec 2006 15:32:24 -0700
Date: Wed, 6 Dec 2006 16:32:23 -0600
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 0/16] Spidernet RX Misc cleanups and fixes
Message-ID: <20061206223223.GH17931@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
	James K Lewis <jklewis@us.ibm.com>, linuxppc-dev@ozlabs.org,
	jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Andrew, 

Please apply and forward upstream. This series of 16 small patches 
consist of mostly of various cleanups, a few fixes, and a clarification
of the flow of the RX side of the spidernet ethernet driver.  The 
first patch, though, is a resubmit of an old patch.

--linas
