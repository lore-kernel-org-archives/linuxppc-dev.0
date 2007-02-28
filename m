Return-Path: <ossthema@de.ibm.com>
Received: from mtagate2.de.ibm.com (mtagate2.de.ibm.com [195.212.29.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4259EDDE07
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Mar 2007 04:40:03 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.13.8/8.13.8) with ESMTP id l1SHdxiU085784
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Feb 2007 17:39:59 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.2) with
	ESMTP id l1SHdwdv2150422
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Feb 2007 18:39:58 +0100
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l1SHdwnO021614
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Feb 2007 18:39:58 +0100
From: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: [PATCH 0/2] ehea: dynamic port & SMP support
Date: Wed, 28 Feb 2007 18:33:45 +0100
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200702281833.45603.ossthema@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>, Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, 

this version has the issues fixed which were mentioned by
Patrick McHardy.

The patch set includes two patches against linux-2.6.21-rc1:

- dynamic add / remove port:
  Interface has been discussed and approved by John Rose
  (see: http://www.spinics.net/lists/netdev/msg25327.html)

- NAPI multi queue TX/RX path for SMP:
  Integrated comments from mailing list (R. Dreier)
  
  As soon as discussions about "splitting NAPI from netdevice"
  have settled and this functionality is in kernel, we'll provide
  a patch for the new interface.
  (see: http://www.spinics.net/lists/netdev/msg25647.html)

please apply.

Jan-Bernd


Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>
	
