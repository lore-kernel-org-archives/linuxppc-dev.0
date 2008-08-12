Return-Path: <alexs@linux.vnet.ibm.com>
Received: from mtagate2.uk.ibm.com (mtagate2.uk.ibm.com [195.212.29.135])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 44F57DDF5E
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 22:49:38 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate2.uk.ibm.com (8.13.8/8.13.8) with ESMTP id m7CCnSD2300866
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 12:49:28 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v9.0) with
	ESMTP id m7CCnRmc3637362
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 13:49:28 +0100
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m7CCnPQv018494
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 13:49:26 +0100
Date: Tue, 12 Aug 2008 14:49:24 +0200
From: Alexander Schmidt <alexs@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>, lkml
	<linux-kernel@vger.kernel.org>, of-ewg <ewg@lists.openfabrics.org>,
	of-general <general@lists.openfabrics.org>, Roland Dreier
	<rolandd@cisco.com>
Subject: [PATCH 0/5] ib/ehca: Fix stability issues
Message-ID: <20080812144924.4447933e@BL3D1974.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Joachim Fenkes <fenkes@de.ibm.com>,
	Stefan Roscher <stefan.roscher@de.ibm.com>,
	Christoph Raisch <raisch@de.ibm.com>, Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Roland,

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
