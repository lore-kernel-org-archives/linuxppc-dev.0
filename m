Return-Path: <ossrosch@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EC84DDE0D1
	for <linuxppc-dev@ozlabs.org>; Thu,  8 May 2008 02:00:23 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m47G0IpM015653
	for <linuxppc-dev@ozlabs.org>; Wed, 7 May 2008 12:00:18 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m47G0Inq292868
	for <linuxppc-dev@ozlabs.org>; Wed, 7 May 2008 12:00:18 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m47G0Hhh019173
	for <linuxppc-dev@ozlabs.org>; Wed, 7 May 2008 12:00:18 -0400
From: Stefan Roscher <ossrosch@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [ewg] [PATCH] IB/ehca: Protect QP against destroying until all
	async events for it are handled.
Date: Wed, 7 May 2008 18:00:14 +0200
References: <200805071319.37164.ossrosch@linux.vnet.ibm.com>
	<adahcdaw2oc.fsf@cisco.com>
In-Reply-To: <adahcdaw2oc.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200805071800.15595.ossrosch@linux.vnet.ibm.com>
Cc: LinuxPPC-Dev <linuxppc-dev@ozlabs.org>, fenkes@de.ibm.com,
	LKML <linux-kernel@vger.kernel.org>, raisch@de.ibm.com,
	OF-EWG <ewg@lists.openfabrics.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 07 May 2008 17:32:03 Roland Dreier wrote:
>  > We are not sure if this should be fixed in the driver or in uverbs itself.
>  > Roland, what's your opinion about this?
> 
> Would be nice to be able to fix it in uverbs but I don't see how.  In
> particular a kernel consumer has to have the same guarantee that no
> async events will come in after destroy QP returns.  And I don't see any
> way generic code can provide a guarantee about what low-level driver
> code may do internally.
> 

I agree, that's why I posted the driver fix first.
So, will you apply it next?

Regards Stefan
