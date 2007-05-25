Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6FB0FDDEFF
	for <linuxppc-dev@ozlabs.org>; Sat, 26 May 2007 00:05:48 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4PE5i1p020451
	for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2007 10:05:44 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4PE5ibq512936
	for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2007 10:05:44 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4PE5ira011053
	for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2007 10:05:44 -0400
Subject: Re: Fix compiler/assembler flags for Ebony platform boot files
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20070525031917.GC13575@localhost.localdomain>
References: <20070525031917.GC13575@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 25 May 2007 09:04:37 -0500
Message-Id: <1180101877.3360.39.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-05-25 at 13:19 +1000, David Gibson wrote:
> The recent addition of assembler flags for 44x.c and ebony.c in the
> bootwrapper to make them compile on certain toolchains was not correct
> and could break other platforms.  This patch switches to using a
> compiler flag instead, which implies the appropriate assembler flag,
> and also stops the compiler itself generating instructions which are
> invalid for the platform in question.

This looks good to me, but I don't have one of the failing toolchains.
Dave, can you test this patch out?

josh
