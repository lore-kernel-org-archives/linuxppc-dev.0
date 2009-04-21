Return-Path: <ossrosch@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 52C05DDF55
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 01:15:40 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n3LFHRGm027078
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2009 11:17:27 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n3LFFYor185216
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2009 11:15:34 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n3LFFY6J016409
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2009 11:15:34 -0400
From: Stefan Roscher <ossrosch@linux.vnet.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>, "OF-EWG" <ewg@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>
Subject: [PATCH 0/3] IB/ehca: Perfomance improvment for creation of queue pairs
Date: Tue, 21 Apr 2009 17:15:32 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200904211715.32625.ossrosch@linux.vnet.ibm.com>
Cc: fenkes@de.ibm.com, alexschm@de.ibm.com, raisch@de.ibm.com,
	stefan.roscher@qde.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patchset contains performance improvments for ehca driver.
It will skip code which is not necessary for userspace queue pairs
and will replace vmalloc() calls with kmalloc().
Because of this fundamental code change we will also increment the version number.

They should apply cleanly against 2.6.30 git tree.

Thanks
Stefan
