Return-Path: <hnguyen@linux.vnet.ibm.com>
Received: from mtagate5.de.ibm.com (mtagate5.de.ibm.com [195.212.29.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E0DF8DDE1F
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 20:41:16 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate5.de.ibm.com (8.13.8/8.13.8) with ESMTP id l6RAfBf7896046
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 10:41:11 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.4) with
	ESMTP id l6RAfBxS1663106
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 12:41:11 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l6RAesLR026992
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 12:40:54 +0200
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, general@lists.openfabrics.org
Subject: [PATCH 0/2] ehca: remove WARNING: externs should be avoided in .c
	files
Date: Fri, 27 Jul 2007 12:52:49 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200707271252.50193.hnguyen@linux.vnet.ibm.com>
Cc: raisch@de.ibm.com, stefan.roscher@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Roland!
This small patch set fixes some coding-style related issues for ehca:
[1/2] remove checkpatch.pl's warnings "externs should be avoided in .c files"
[2/2] correction include order according kernel coding style
Thanks
Nam
