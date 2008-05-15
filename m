Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 84CD4DDEEA
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 22:06:50 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4FC6i6W029937
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 08:06:44 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4FC6idv112000
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 08:06:44 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4FC6hO7029442
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 08:06:44 -0400
Date: Thu, 15 May 2008 07:03:35 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: Convert remaining dts-v0 files to v1
Message-ID: <20080515070335.5d9a98e5@zod.rchland.ibm.com>
In-Reply-To: <20080515064639.GB30996@yookeroo.seuss>
References: <20080515064639.GB30996@yookeroo.seuss>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 15 May 2008 16:46:39 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> At the moment we have a mixture of left-over version 0 and new-format
> version 1 files in arch/powerpc/boot/dts.  This is potentially
> confusing to people new to the dts format attempting to figure it out.
> 
> So, this patch converts all the as-yet unconverted dts v0 files and
> converts them to v1.  They're mechanically-converted, and not hand
> tweaked so in some cases they're not 100% in keeping with usual v1
> style, but the convertor program does have some heuristics so the
> discrepancies aren't too bad.
> 
> I have checked that this patch produces no changes to the resulting
> dtb binaries.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

The only dts affected that isn't something I maintain or wrote (holly)
is the ps3.dts.  How do we want to handle this one?  I'd like to get it
into my tree soon (today/tomorrow) as I'm queuing up patches for .27 at
the moment.

As for the 4xx and holly dts changes:

Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

josh
