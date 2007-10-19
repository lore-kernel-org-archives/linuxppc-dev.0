Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2D704DDED5
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 01:00:18 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l9JDpIp9003712
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 09:51:18 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9JF0Evk089780
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 09:00:14 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9JF0ELx009028
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 09:00:14 -0600
Received: from [9.10.86.71] (weaponx.rchland.ibm.com [9.10.86.71])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l9JF0EOu008376
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 09:00:14 -0600
Message-Id: <20071019145307.978880000@linux.vnet.ibm.com>>
Date: Fri, 19 Oct 2007 09:53:08 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [patch 0/4] Small 4xx fixes for 2.6.24
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This series of patches enables the EMAC driver for the Ebony, Walnut, and
Bamboo boards.  There's also a timebase fix for Walnut.

I'll put these and a few other patches that have been sent to me into my git
tree later today and ask Paul to pull.

josh  

-- 
