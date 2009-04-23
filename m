Return-Path: <mjw@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4BB7EDE124
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2009 07:57:05 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e8.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n3NLloVb003670
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 17:47:50 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n3NLv1q9193926
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 17:57:01 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n3NLv1X3019901
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 17:57:01 -0400
Subject: Re: [PATCH] powerpc: adjust oprofile_cpu_type
From: Mike Wolf <mjw@linux.vnet.ibm.com>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20090423175210.GB4732@lixom.net>
References: <1240443612.27209.2.camel@mx3> <20090423175210.GB4732@lixom.net>
Content-Type: text/plain
Date: Thu, 23 Apr 2009 16:56:56 -0500
Message-Id: <1240523816.12000.2.camel@mx3>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: mjw@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-04-23 at 12:52 -0500, Olof Johansson wrote:
> On Wed, Apr 22, 2009 at 06:40:12PM -0500, Mike Wolf wrote:
> > Resending.  the patch was munged last time.
> > 
> > 
> > Oprofile is changing the naming it is using for the compatibility modes.
> > Instead of having compat-power<x>, oprofile will go to family naming
> > convention and use compat-v<x>.  Currently only compat-v1 will be
> > defined.
> 
> Compat V1 of what? powerpc64? IBM powerpc64 PMC? 

IBM powerpc PMC

>  The performance
> monitors are not architected, to give them a version number without
> vendor information seems weird.
The current ones all fall into one family and they may be architected in
the future.
> 
> Also, doesn't this break compatibility with existing userspace tools?
AFAIK there is nothing else that uses these.  Oprofile patch was
rejected and this new naming was suggested from that community.

Mike
