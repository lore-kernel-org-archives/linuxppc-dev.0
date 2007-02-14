Return-Path: <hnguyen@linux.vnet.ibm.com>
Received: from mtagate1.uk.ibm.com (mtagate1.uk.ibm.com [195.212.29.134])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 02333DDEE1
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 03:44:03 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate1.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l1EGhvmW073326
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 16:43:58 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.2) with
	ESMTP id l1EGhvUf1425596
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 16:43:57 GMT
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l1EGhuig025821
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 16:43:57 GMT
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, openib-general@openib.org, hch@infradead.org
Subject: [PATCH 2.6.21-rc1 0/5] ehca patch set for 2.6.21-rc1
Date: Wed, 14 Feb 2007 17:40:30 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200702141740.30637.hnguyen@linux.vnet.ibm.com>
Cc: raisch@de.ibm.com, h.carstens@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Roland!
Here is a patch set for ehca with the following changes resp. bug fixes:
* Reworked irq handler to avoid/reduce missed irq events
* Fix race condition bug in find_next_online_cpu() and other potential
  locking issue of scaling code
* Allow scaling code to be configurable (en-/disable) via module parameter
* Replace yield() in ehca_destroy_cq() by wait_for_completion()
* ehca_query_port() now returns LINK_UP for phys_state instead UNKNOWN
Thanks!
Nam
