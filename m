Return-Path: <hannes.hering@linux.vnet.ibm.com>
Received: from mtagate6.de.ibm.com (mtagate6.de.ibm.com [195.212.29.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4075BDDE1D
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 22:39:59 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate6.de.ibm.com (8.13.8/8.13.8) with ESMTP id m47Cd6RQ393868
	for <linuxppc-dev@ozlabs.org>; Wed, 7 May 2008 12:39:06 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id m47Cd6le3674248
	for <linuxppc-dev@ozlabs.org>; Wed, 7 May 2008 14:39:06 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m47Cd5LR015901
	for <linuxppc-dev@ozlabs.org>; Wed, 7 May 2008 14:39:06 +0200
Subject: [PATCH 0/3] [2.6.26] ehea: Add DLPAR memory remove support
From: Hannes Hering <hannes.hering@linux.vnet.ibm.com>
Date: Wed, 7 May 2008 14:39:06 +0200
MIME-Version: 1.0
To: jeff@garzik.org
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200805071439.06460.hannes.hering@linux.vnet.ibm.com>
Cc: tklein@de.ibm.com, themann@de.ibm.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, raisch@de.ibm.com,
	ossrosch@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org, ossthema@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

this patchset adds memory remove hotplug support for the ehea driver. 

These patches apply against kernel 2.6.26-rc1.

Regards

Hannes
