Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 35828DDE0A
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jun 2007 12:39:52 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp04.au.ibm.com (8.13.8/8.13.8) with ESMTP id l5Q31m4n128754
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jun 2007 13:01:48 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.250.243])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l5Q2hGlE142104
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jun 2007 12:43:17 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l5Q2dh2Q002585
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jun 2007 12:39:43 +1000
Date: Tue, 26 Jun 2007 12:35:22 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: dtc: Remove redundant copy of the GPL
Message-ID: <20070626023522.GF4383@localhost.localdomain>
References: <20070626014449.GD4383@localhost.localdomain>
	<20070626023305.GA11906@crusty.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070626023305.GA11906@crusty.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 25, 2007 at 09:33:06PM -0500, Josh Boyer wrote:
> On Tue, Jun 26, 2007 at 11:44:49AM +1000, David Gibson wrote:
> > The dtc tree currently includes two copies of the GPL - one which was
> > there originally, and one imported from the libfdt tree.  This patch
> > gets rid of the extra copy in the libfdt tree.
> > 
> > In addition it renames the file containing the remaining copy from
> > COPYING to GPL.  Since libfdt is dual-licensed, this seems clearer.
> 
> You might want to remove the mysterious reference to the LGPL in the
> EXTRA_DIST variable in the Makefile while you're at it.

I have another patch coming which revamps the Makefiles, including get
of that hangover (it's there because I stole the Makefiles from
libhugetlbfs which is LGPL).

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
