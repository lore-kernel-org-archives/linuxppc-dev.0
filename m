Return-Path: <ossthema@de.ibm.com>
Received: from mtagate4.de.ibm.com (mtagate4.de.ibm.com [195.212.29.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4098FDDEDF
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jul 2008 19:08:30 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.13.8/8.13.8) with ESMTP id m6798BF1027894
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 09:08:11 GMT
Received: from d12av01.megacenter.de.ibm.com (d12av01.megacenter.de.ibm.com
	[9.149.165.212])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.0) with
	ESMTP id m6798Brw3604594
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 11:08:11 +0200
Received: from d12av01.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av01.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m6798AXX003369
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 11:08:10 +0200
From: Jan-Bernd Themann <ossthema@de.ibm.com>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: [BUG] 2.6.26-rc8-git2 - powerpc - circular locking dependency
	detected with net/ehea driver
Date: Mon, 7 Jul 2008 10:08:08 +0100
References: <486A2553.1090207@linux.vnet.ibm.com>
In-Reply-To: <486A2553.1090207@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807071108.09616.ossthema@de.ibm.com>
Cc: netdev@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, kernel-testers@vger.kernel.org,
	jgarzik@pobox.com, Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Kamalesh,

where you able to reproduce this problem with the patches applied
we posted on friday?

Regards,
Jan-Bernd

On Tuesday 01 July 2008 14:38, Kamalesh Babulal wrote:
> Hi,
> 
> circular locking dependency is detected, while booting the
> powerpc box with the 2.6.26-rc8-git2 kernel.
> 
> =======================================================
> [ INFO: possible circular locking dependency detected ]
> 2.6.26-rc8-git2 #1
> -------------------------------------------------------
