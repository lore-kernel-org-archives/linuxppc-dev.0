Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 81E9ADDED5
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 03:35:46 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lBIGZX3Q010457
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Dec 2007 11:35:33 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lBIGZXNp126120
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Dec 2007 11:35:33 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lBIGZW3U020825
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Dec 2007 11:35:33 -0500
Date: Tue, 18 Dec 2007 10:30:27 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Raising list size limit
Message-ID: <20071218103027.37c54bb0@zod.rchland.ibm.com>
In-Reply-To: <2420E261-C9AB-49B8-8F99-C24C7A865044@kernel.crashing.org>
References: <20071218143627.94f76142.sfr@canb.auug.org.au>
	<20071218060105.368f0bd4@zod.rchland.ibm.com>
	<2420E261-C9AB-49B8-8F99-C24C7A865044@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 18 Dec 2007 09:54:15 -0600
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> On Dec 18, 2007, at 6:01 AM, Josh Boyer wrote:
> 
> > On Tue, 18 Dec 2007 14:36:27 +1100
> > Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> >> Hi,
> >>
> >> I am considering raising the limit on the size of postings to  
> >> 400k.  Does
> >> anyone have a real problem with this?  Limiting message size was  
> >> done to
> >> limit the damage of larges spams (and we don;t get very many of  
> >> those on
> >> the list) and to ease the pain for people downloading emails over a  
> >> slow
> >> (like dialup) link (and are there many of those left?).
> >
> > Fine by me!
> 
> Do you really have patches that are 400k?

Nope.  But I don't really care if I get them.

josh
