Return-Path: <hollisb@us.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 85C88DE661
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 00:27:01 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m3AEQvD4002378
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 10:26:57 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m3AEQvnY250392
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 10:26:57 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m3AEQvNQ013974
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 10:26:57 -0400
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 0 of 3] KVM for PowerPC 440
Date: Thu, 10 Apr 2008 09:26:56 -0500
References: <patchbomb.1207601611@localhost.localdomain>
	<20080410065518.46979767@zod.rchland.ibm.com>
In-Reply-To: <20080410065518.46979767@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804100926.56533.hollisb@us.ibm.com>
Cc: kvm-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org,
	kvm-ppc-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 10 April 2008 06:55:18 Josh Boyer wrote:
> On Mon, 07 Apr 2008 15:53:31 -0500
>
> Hollis Blanchard <hollisb@us.ibm.com> wrote:
> > Implement initial support for KVM for PowerPC 440. There are just two
> > small prerequisite patches, and then the bulk of the code can't be split
> > easily.
> >
> > Please review; I would like to submit these for 2.6.26. There is plenty
> > of work to do, both functional and optimization, but this code is
> > sufficient to run unmodified 440 Linux guests on a 440 Linux host. What's
> > your favorite bike shed color?
>
> Who's tree are you looking to get this patch set into?

Since the only PPC-specific change is patch 1, if I can get your Acked-by for 
it I will send it via Avi.

-- 
Hollis Blanchard
IBM Linux Technology Center
