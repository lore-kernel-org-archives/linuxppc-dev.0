Return-Path: <linas@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 73868DDE08
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 09:36:44 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lALLZcAm026503
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 16:35:38 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lALMafiT106506
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 15:36:41 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lALMaedY029724
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 15:36:41 -0700
Date: Wed, 21 Nov 2007 16:36:40 -0600
To: linuxppc-dev@ozlabs.org
Subject: [PATCH/RFC 0/6]: phyp dump: hypervisor-assisted dump
Message-ID: <20071121223639.GB4374@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: linas@austin.ibm.com (Linas Vepstas)
Cc: mahuja@us.ibm.com, lkessler@us.ibm.com, strosake@us.ibm.com,
	mahuja@austin.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The following series of patches implement a basic framework
for hypervisor-assisted dump. The very first patch provides 
documentation explaining what this is :-). Yes, its supposed
to be an improvement over kdump.

The patches mostly sort-of work; a list of open issues
is inculded in the documentation.  It also appears that 
the not-yet-released firmware versions this was tested 
on are still, ahem, incomplete; this work is also pending.

-- Linas & Manish
