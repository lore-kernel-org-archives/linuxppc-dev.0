Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E0ED6DDE48
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 21:51:07 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l79AiZSu026450
	for <linuxppc-dev@ozlabs.org>; Thu, 9 Aug 2007 06:44:35 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l79Bp4uT270772
	for <linuxppc-dev@ozlabs.org>; Thu, 9 Aug 2007 05:51:04 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l79Bp3oC014071
	for <linuxppc-dev@ozlabs.org>; Thu, 9 Aug 2007 05:51:04 -0600
Date: Thu, 9 Aug 2007 07:04:51 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Fix small race in 44x tlbie function
Message-ID: <20070809120450.GE3925@crusty.rchland.ibm.com>
References: <20070807042050.GJ13522@localhost.localdomain>
	<BDA0DE7D-8AD8-4116-ABE0-2DF6AE72A516@kernel.crashing.org>
	<20070808110029.43c110ef@weaponx.rchland.ibm.com>
	<57F869A4-38DE-4CC9-A07D-C3A873CE9268@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <57F869A4-38DE-4CC9-A07D-C3A873CE9268@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Volkmar Uhlig <vuhlig@us.ibm.com>,
	Paul Mackerras <paulus@samba.org>, Todd Inglett <tinglett@us.ibm.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 09, 2007 at 12:28:20AM -0500, Kumar Gala wrote:
> >>Did you actually see this happen?
> >
> >Yes.
> 
> When?

During some bluegene debug.

> We don't have critical wired to anything, I don't expect watchdog to  
> cause another fault.. so just wondering.

We being who?  I'm slightly confused here.

josh
