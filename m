Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 778B5DDEE2
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2007 14:16:11 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp04.au.ibm.com (8.13.8/8.13.8) with ESMTP id l774JAJI342898
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Aug 2007 14:19:10 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.250.244])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l774Jd9Q197300
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Aug 2007 14:19:39 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l774G5LB031086
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Aug 2007 14:16:06 +1000
Date: Tue, 7 Aug 2007 14:14:23 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PING][PATCH] PPC 4xx HW Watchpoint
Message-ID: <20070807041423.GG13522@localhost.localdomain>
References: <OFC73E3C0F.0CFFE8F0-ON8325732F.00741361-8325732F.00749AD1@br.ibm.com>
	<20070807000824.GB3925@crusty.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070807000824.GB3925@crusty.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Aug 06, 2007 at 07:08:25PM -0500, Josh Boyer wrote:
> On Mon, Aug 06, 2007 at 06:10:29PM -0300, rrbranco@br.ibm.com wrote:
> > Hello guys,
> > 
> > I'm just writting to know if someone have some opinion about the patch I 
> > sent a week ago.  I'm not sending it again cause I'm traveling and don't 
> > have it here in this machine.
> 
> Sorry Rodrigo.  I'll try to find some time this week to review it.  It's been
> on my list, I just haven't gotten to it yet.

Same here, pretty much.  I don't really know enough about the general
ptrace() architecture to know where to start, particularly.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
