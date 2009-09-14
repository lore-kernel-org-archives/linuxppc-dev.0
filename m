Return-Path: <dwalker@fifo99.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 36D61B70AD
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Sep 2009 04:23:17 +1000 (EST)
Received: from fifo99.com (fifo99.com [67.223.236.141])
	by ozlabs.org (Postfix) with ESMTP id E3FBFDDD0B
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2009 04:23:16 +1000 (EST)
Subject: Re: [PATCH 0/5] kernel handling of dynamic logical partitioning
From: Daniel Walker <dwalker@fifo99.com>
To: Nathan Fontenot <nfont@austin.ibm.com>
In-Reply-To: <4AAE89CE.2030804@austin.ibm.com>
References: <4AAABC55.4070207@austin.ibm.com>
	<1252704198.28368.31.camel@desktop> <4AAE89CE.2030804@austin.ibm.com>
Content-Type: text/plain
Date: Mon, 14 Sep 2009 11:24:00 -0700
Message-Id: <1252952640.11643.64.camel@desktop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-09-14 at 13:22 -0500, Nathan Fontenot wrote:
> Daniel Walker wrote:
> > On Fri, 2009-09-11 at 16:08 -0500, Nathan Fontenot wrote:
> >>  am cc'ing lkml.
> >>
> >> Patches include in this set:
> >> 1/5 - DLPAR infrastructure for powerpc/pseries platform.
> >> 2/5 - Move the of_drconf_cell struct to prom.h
> >> 3/5 - Export the memory sysdev class
> >> 4/5 - Memory DLPAR handling
> >> 5/5 - CPU DLPAR handling
> >>
> > 
> > It looks like a couple of your patches have some checkpatch issues..
> > Could you run these through scripts/checkpatch.pl and clean up any
> > problems it raises ? Specifically patches 1, 4, and 5 ..
> > 
> 
> thanks for checking this, I obviously forgot.  I'll post updated patches
> (after running checkpatch on them) with fixes.

Ok, thanks..

Daniel
