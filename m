Return-Path: <ossrosch@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6921ADDE25
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 01:01:53 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5AF1nIr011744
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jun 2008 11:01:49 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5AF1nX9156924
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jun 2008 11:01:49 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5AF1mOF001304
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jun 2008 11:01:49 -0400
From: Stefan Roscher <ossrosch@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [PATCH REPOST] IB/ehca: In case of lost interrupts,
	trigger EOI to reenable interrupts
Date: Tue, 10 Jun 2008 17:01:45 +0200
References: <200806101644.34693.ossrosch@linux.vnet.ibm.com>
	<adatzg15ol2.fsf@cisco.com>
In-Reply-To: <adatzg15ol2.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806101701.47090.ossrosch@linux.vnet.ibm.com>
Cc: TKLEIN@de.ibm.com, THEMANN@de.ibm.com, fenkes@de.ibm.com,
	LKML <linux-kernel@vger.kernel.org>, OF-EWG <ewg@lists.openfabrics.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>, raisch@de.ibm.com,
	Paul Mackerras <paulus@samba.org>, general@lists.openfabrics.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 10 June 2008 16:52:57 Roland Dreier wrote:
>  > During corner case testing, we noticed that some versions of ehca 
>  > do not properly transition to interrupt done in special load situations.
>  > This can be resolved by periodically triggering EOI through H_EOI, 
>  > if eqes are pending.
> 
> So just to be clear: this is a workaround for a hardware/firmware bug?
> 
>  - R.
> 

Yes it is.
regards Stefan
