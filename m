Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 97B6BDDEA3
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 23:27:10 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l79DSOf9023505
	for <linuxppc-dev@ozlabs.org>; Thu, 9 Aug 2007 09:28:24 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l79DR5GW396836
	for <linuxppc-dev@ozlabs.org>; Thu, 9 Aug 2007 09:27:05 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l79DR5PM031624
	for <linuxppc-dev@ozlabs.org>; Thu, 9 Aug 2007 09:27:05 -0400
Date: Thu, 9 Aug 2007 08:26:59 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Fix small race in 44x tlbie function
Message-ID: <20070809082659.0df0af0a@zod.rchland.ibm.com>
In-Reply-To: <1186664737.481.28.camel@localhost.localdomain>
References: <20070807042050.GJ13522@localhost.localdomain>
	<BDA0DE7D-8AD8-4116-ABE0-2DF6AE72A516@kernel.crashing.org>
	<20070808110029.43c110ef@weaponx.rchland.ibm.com>
	<57F869A4-38DE-4CC9-A07D-C3A873CE9268@kernel.crashing.org>
	<20070809120450.GE3925@crusty.rchland.ibm.com>
	<1186664737.481.28.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Uhlig <vuhlig@us.ibm.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>,
	Todd Inglett <tinglett@us.ibm.com>, Volkmar,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 09 Aug 2007 23:05:36 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Thu, 2007-08-09 at 07:04 -0500, Josh Boyer wrote:
> > 
> > > We don't have critical wired to anything, I don't expect watchdog
> > to  
> > > cause another fault.. so just wondering.
> > 
> > We being who?  I'm slightly confused here. 
> 
> I think Kumar doesn't know that we are talking about the BG kernel
> which has more things "wired" to CRIT than what is upstream at the
> moment :-)

Ah, sure.  But even though we don't have much upstream that uses CE,
that doesn't mean someone can't reprogram the UICs on their boards to
use CE for some things, for example.  I know of at least one project
that has done that in the past.

josh
