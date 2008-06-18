Return-Path: <jschopp@austin.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 915C4DE0A4
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jun 2008 06:12:27 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5IKCOTr000531
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 16:12:24 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5IKCIuZ119072
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 14:12:19 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5IKCIRq024763
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 14:12:18 -0600
Date: Wed, 18 Jun 2008 15:11:24 -0500
From: jschopp@austin.ibm.com
To: paulus@samba.org
Subject: [PATCH 0/2] more power7 bits
Message-ID: <20080618201124.GA23828@gamma>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The patches following add some additional cputable, architecture-vec, etc bits 
for Power7.  Specifically the bits for running in 2.06 architected mode. 
