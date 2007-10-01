Return-Path: <ossthema@de.ibm.com>
Received: from mtagate7.de.ibm.com (mtagate7.de.ibm.com [195.212.29.156])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A082EDDDF9
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 00:54:19 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate7.de.ibm.com (8.13.8/8.13.8) with ESMTP id l91EsFew374506
	for <linuxppc-dev@ozlabs.org>; Mon, 1 Oct 2007 14:54:15 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l91EsETS2101322
	for <linuxppc-dev@ozlabs.org>; Mon, 1 Oct 2007 16:54:14 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l91EsEXT007762
	for <linuxppc-dev@ozlabs.org>; Mon, 1 Oct 2007 16:54:14 +0200
From: Jan-Bernd Themann <ossthema@de.ibm.com>
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ehea: DLPAR memory add fix
Date: Mon, 1 Oct 2007 16:54:13 +0200
References: <200710011633.18305.ossthema@de.ibm.com>
	<470107D9.2040301@garzik.org>
In-Reply-To: <470107D9.2040301@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710011654.14067.ossthema@de.ibm.com>
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

On Monday 01 October 2007 16:44, Jeff Garzik wrote:
> Jan-Bernd Themann wrote:
> > Due to stability issues in high load situations the HW queue handling
> > has to be changed. The HW queues are now stopped and restarted again instead
> > of destroying and allocating new HW queues. 
> > 
> > Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>
> 
> May I presume this is for 2.6.23?
> 
> 	Jeff

no, the patch is build against 2.6.24 upstream (new NAPI interface).

Regards,
Jan-Bernd
