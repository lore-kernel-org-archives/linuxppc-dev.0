Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F086DDDEEF
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2007 22:50:39 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l5PCoZQg005238
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2007 08:50:35 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l5PCoZ2a250026
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2007 06:50:35 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l5PCoYXW024990
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2007 06:50:35 -0600
Subject: Re: [PATCH] powerpc: fix MAC address entries for 83xx, 85xx, and
	86xx device trees
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <70d005ce549921cc56481fe0b26faaa4@kernel.crashing.org>
References: <11825407952085-git-send-email-timur@freescale.com>
	<70d005ce549921cc56481fe0b26faaa4@kernel.crashing.org>
Content-Type: text/plain
Date: Mon, 25 Jun 2007 07:50:33 -0500
Message-Id: <1182775833.23775.4.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2007-06-23 at 17:50 +0200, Segher Boessenkool wrote:
> > For the 83xx, 85xx, and 86xx device trees, add a "local-mac-address" 
> > property
> > to every Ethernet node that didn't have one.  Add a comment indicating 
> > that
> > the "address" and/or "mac-address" properties are deprecated in DTS 
> > files
> > and will be removed at a later time.  Change all MAC address 
> > properties to
> > have a zero MAC address value.
> 
> Shouldn't you use the "??" notation instead, or is that
> still not implemented?

Not implemented.

josh
