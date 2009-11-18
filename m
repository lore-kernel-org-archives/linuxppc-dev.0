Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D40EB1007D1
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2009 14:32:33 +1100 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp07.au.ibm.com (8.14.3/8.13.1) with ESMTP id nAI3WWph019584
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2009 14:32:32 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nAI3TEjl1073368
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2009 14:29:14 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nAI3WWmS025889
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2009 14:32:32 +1100
Date: Wed, 18 Nov 2009 13:36:27 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Sachin Sant <sachinp@in.ibm.com>
Subject: Re: [powerpc] Next tree Nov 2 : kernel BUG at mm/mmap.c:2135!
Message-ID: <20091118023627.GC11991@yookeroo>
References: <20091102173845.210d1c57.sfr@canb.auug.org.au>
	<4AEEA279.4040106@in.ibm.com> <4AF175D4.7030507@in.ibm.com>
	<20091105001650.GD3613@yookeroo.seuss>
	<4AFBEE98.2070208@in.ibm.com>
	<20091113013729.GB18848@yookeroo.seuss>
	<20091113021048.GA4865@yookeroo.seuss>
	<4AFD2865.5090503@in.ibm.com> <20091117052542.GB2576@yookeroo>
	<4B02529F.1060801@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4B02529F.1060801@in.ibm.com>
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>, linux-next@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 17, 2009 at 01:07:03PM +0530, Sachin Sant wrote:
> David Gibson wrote:
> >Hrm.  Ok.  I am truly baffled.  Well, below is a revised debug patch
> >which I hope will shed some sort of light on things.  I do also notice
> Thanks for the debug patch. I have attached the collected information.
> 
> >from your full log that it looks like the bug is happening shortly
> >after we start userspace.  So it may be differences in my userspace
> >set up that meant I haven't been able to reproduce it.  I'll have
> >another look at that when I get a chance.
> Let me know if you need access to the system on which i can recreate the
> bug. I can make that system available for you to debug this issue.

That's probably a good idea.  I'm still pretty baffled by this, so it
will probably take several more rounds of debug patches to start
getting a handle on it.


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
