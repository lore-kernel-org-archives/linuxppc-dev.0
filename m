Return-Path: <alexs@linux.vnet.ibm.com>
Received: from mtagate2.uk.ibm.com (mtagate2.uk.ibm.com [194.196.100.162])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D1DAFDDF1E
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2009 00:13:50 +1000 (EST)
Received: from d06nrmr1707.portsmouth.uk.ibm.com
	(d06nrmr1707.portsmouth.uk.ibm.com [9.149.39.225])
	by mtagate2.uk.ibm.com (8.13.1/8.13.1) with ESMTP id n3SEDjPh028484
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 14:13:45 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by d06nrmr1707.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v9.2) with
	ESMTP id n3SEDjK61323174
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 15:13:45 +0100
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id n3SEDhlW015414
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 15:13:44 +0100
Date: Tue, 28 Apr 2009 16:13:42 +0200
From: Alexander Schmidt <alexs@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [ewg] Re: [PATCH 1/3] IB/ehca: Replace vmalloc with kmalloc
Message-ID: <20090428161342.2037c8fc@BL3D1974.boeblingen.de.ibm.com>
In-Reply-To: <adabpqgx4g3.fsf@cisco.com>
References: <200904211716.45245.ossrosch@linux.vnet.ibm.com>
	<adaws9dvrkp.fsf@cisco.com>
	<200904221602.29028.ossrosch@linux.vnet.ibm.com>
	<20090428150736.1ea143f0@BL3D1974.boeblingen.de.ibm.com>
	<adabpqgx4g3.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: fenkes@de.ibm.com, OF-EWG <ewg@lists.openfabrics.org>,
	LKML <linux-kernel@vger.kernel.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>, raisch@de.ibm.com,
	alexschm@de.ibm.com, Stefan Roscher <ossrosch@linux.vnet.ibm.com>,
	stefan.roscher@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 28 Apr 2009 07:01:32 -0700
Roland Dreier <rdreier@cisco.com> wrote:

>  > did you have a chance to take a look at the patchset and will you apply it, or
>  > are there any outstanding issues we need to address?
> 
> I guess it's OK, but definitely 2.6.31 material.  I guess I'll stick it
> linux-next soon.
> 
>  - R.

Okay with us, thank you very much!

Alex
