Return-Path: <alexs@linux.vnet.ibm.com>
Received: from mtagate2.uk.ibm.com (mtagate2.uk.ibm.com [195.212.29.135])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 11187DE0F2
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 23:46:35 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate2.uk.ibm.com (8.13.8/8.13.8) with ESMTP id m7CDk3jP041054
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 13:46:03 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
	[9.149.37.213])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v9.0) with
	ESMTP id m7CDk2DR1118308
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 14:46:02 +0100
Received: from d06av03.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m7CDk266020688
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 14:46:02 +0100
From: Alexander Schmidt <alexs@linux.vnet.ibm.com>
To: Roland Dreier <rolandd@cisco.com>, "of-ewg" <ewg@lists.openfabrics.org>,
	"of-general" <general@lists.openfabrics.org>,
	lkml <linux-kernel@vger.kernel.org>,
	"linuxppc-dev" <linuxppc-dev@ozlabs.org>
Subject: [PATCH 0/5 try2] ib/ehca: Fix stability issues
Date: Tue, 12 Aug 2008 15:46:00 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200808121546.00211.alexs@linux.vnet.ibm.com>
Cc: Joachim Fenkes <fenkes@de.ibm.com>,
	Stefan Roscher <stefan.roscher@de.ibm.com>,
	Christoph Raisch <raisch@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Roland,

Sorry, the first set was mangled because of a broken mailer, so here it is
again, double checked...

the following patchset contains four small fixes and one bigger patch
(5/5) for addressing some ehca issues we found during cluster test.

[1/5] update qp_state on cached modify_qp()
[2/5] rename goto label in ehca_poll_cq_one()
[3/5] repoll on invalid opcode instead of returning success
[4/5] check idr_find() return value
[5/5] discard double CQE for one WR

They all apply on top of 2.6.27-rc1. If possible, we would like to get
them into 2.6.27.

Regards,
Alexander Schmidt
