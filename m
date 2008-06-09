Return-Path: <ossrosch@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0350CDE6A9
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jun 2008 01:42:54 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m59FgfJu027443
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Jun 2008 11:42:41 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m59FgVnA204472
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Jun 2008 11:42:31 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m59FgU7s011753
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Jun 2008 11:42:31 -0400
From: Stefan Roscher <ossrosch@linux.vnet.ibm.com>
To: Roland Dreier <rolandd@cisco.com>, "OF-EWG" <ewg@lists.openfabrics.org>,
	general@lists.openfabrics.org, "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] Prevent loss of interrupts in IB/ehca
Date: Mon, 9 Jun 2008 17:42:28 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806091742.29421.ossrosch@linux.vnet.ibm.com>
Cc: TKLEIN@de.ibm.com, fenkes@de.ibm.com, raisch@de.ibm.com, THEMANN@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patchset contains two changes for IB/ehca and ibmebus.

The first patch enables ibmebus_request_irq() to optionally return the 
IRQ number, which is used by the second patch to trigger EOI in case of 
lost interrupts.

They should apply cleanly against 2.6.26 git tree.

Thanks
Stefan
