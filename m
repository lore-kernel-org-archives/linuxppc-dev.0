Return-Path: <hnguyen@linux.vnet.ibm.com>
Received: from mtagate6.uk.ibm.com (mtagate6.uk.ibm.com [195.212.29.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 74EC3DDDFA
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 23:37:18 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate6.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l6KDbCIk447092
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 13:37:12 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.4) with
	ESMTP id l6KDbChx2994402
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 14:37:12 +0100
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l6KDatfF004730
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 14:36:56 +0100
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: rolandd@cisco.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	openib-general@openib.org
Subject: [PATCH 0/5] ehca: MR large page, small queue and fixes
Date: Fri, 20 Jul 2007 15:48:35 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200707201548.36047.hnguyen@linux.vnet.ibm.com>
Cc: fenkes@de.ibm.com, raisch@de.ibm.com, stefan.roscher@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here is a patch set against Roland's git, branch for-2.6.23 for ehca.
It adds support for MR large page and small queues. In addition of that
it also contains various small fixes from previous comments and what
we found.

They are in details:
[1/5] adds support for MR large page
[2/5] generates event when SRQ limit reached
[3/5] makes ehca2ib_return_code() non inline
[4/5] makes internal_create/destroy_qp() static
[5/5] adds support for small queues

The patches should apply cleanly, in order, against Roland's git. Please
review the changes and apply the patches if they are okay.

Regards,
Nam & Stefan
