Return-Path: <ananth@in.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 66A86B7D1F
	for <linuxppc-dev@ozlabs.org>; Fri, 28 May 2010 13:53:30 +1000 (EST)
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e4.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o4S3eY0l011611
	for <linuxppc-dev@ozlabs.org>; Thu, 27 May 2010 23:40:34 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4S3q94i1294432
	for <linuxppc-dev@ozlabs.org>; Thu, 27 May 2010 23:52:09 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4S3q965031152
	for <linuxppc-dev@ozlabs.org>; Fri, 28 May 2010 00:52:09 -0300
Date: Fri, 28 May 2010 09:22:05 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC PATCH] powerpc: Emulate nop too
Message-ID: <20100528035205.GA25946@in.ibm.com>
References: <20100520124955.GA29903@brick.ozlabs.ibm.com>
	<20100527141203.GA20770@in.ibm.com>
	<666A1FDB-C8EC-493A-957E-3C4291CCB439@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <666A1FDB-C8EC-493A-957E-3C4291CCB439@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
	"K.Prasad" <prasad@linux.vnet.ibm.com>
Reply-To: ananth@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 27, 2010 at 03:22:45PM -0500, Kumar Gala wrote:
> 
> On May 27, 2010, at 9:12 AM, Ananth N Mavinakayanahalli wrote:
> 
> > Hi Paul,
> > 
> > While we are at it, can we also add nop to the list of emulated
> > instructions?
> 
> Dare I ask why we need to emulate nop?

We are close to getting userspace probes done. Some userspace apps
that've gained 'markers' from DTrace or elsewhere, are being enabled to
expose those in through debuginfo on Linux and the underlying instruction
there is a nop.

Ananth
