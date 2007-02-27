Return-Path: <ossthema@de.ibm.com>
Received: from mtagate7.uk.ibm.com (mtagate7.uk.ibm.com [195.212.29.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 05CCADDEB8
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Feb 2007 04:08:08 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate7.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l1RGc7M1053912
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Feb 2007 16:38:07 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.2) with
	ESMTP id l1RGc7AK1298438
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Feb 2007 16:38:07 GMT
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l1RGc6jo016988
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Feb 2007 16:38:07 GMT
From: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: [PATCH 0/2] ehea: dynamic port & SMP support
Date: Tue, 27 Feb 2007 17:32:02 +0100
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200702271732.02531.ossthema@de.ibm.com>
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

This patch set includes two patches against linux-2.6.21-rc1:

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
