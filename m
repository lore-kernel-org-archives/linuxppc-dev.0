Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5FC6BDDDFC
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 02:28:58 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lB4FSr1E026969
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Dec 2007 10:28:53 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lB4FSrJC095578
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Dec 2007 10:28:53 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lB4FSrsx000717
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Dec 2007 10:28:53 -0500
Date: Tue, 4 Dec 2007 09:26:11 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: Merge dtc
Message-ID: <20071204092611.79e08953@zod.rchland.ibm.com>
In-Reply-To: <E1IzXmf-0005RJ-27@jdl.com>
References: <20071016050217.GA9052@localhost.localdomain>
	<1196733544.13978.201.camel@pmac.infradead.org>
	<E1IzXmf-0005RJ-27@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul, David Woodhouse <dwmw2@infradead.org>,
	Mackerras <paulus@samba.org>, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 04 Dec 2007 07:25:57 -0600
Jon Loeliger <jdl@jdl.com> wrote:

> So, like, the other day David Woodhouse mumbled:
> > 
> > I think this is a bad idea -- it's hardly a difficult for those people
> > who _do_ need dts to obtain it separately.
> > 
> > We shouldn't be merging _more_ stuff in.
> 
> Thanks for chiming in here, David W.  As far as I can tell
> so far, the only two people who have voiced an opinion on
> this issue are Dave G, submitting patches, and me disagreeing
> with the approach.  :-)
> 
> Anyone else?

I don't see an overwhelmingly great reason to merge it.  It might help
test people who do automated rebuilds, etc and aren't used to dealing
with powerpc and it's requirements.  Outside of that, I see it as
dual-maintenance.

But I'm not doing the maintenance, and it doesn't effect me too much.
I only ask that a decision is made and executed on soon so we can move
on.

josh
