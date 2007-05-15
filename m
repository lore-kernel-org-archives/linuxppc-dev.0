Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C7B47DDEBE
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 12:43:08 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4F2h6b4028943
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 22:43:06 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4F2h5uY257954
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 20:43:05 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4F2h5d2025191
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 20:43:05 -0600
Subject: Re: [PATCH 2/3] Bamboo platform support
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20070515120321.8385a60f.sfr@canb.auug.org.au>
References: <1179154608.3420.21.camel@zod.rchland.ibm.com>
	<1179154743.3420.25.camel@zod.rchland.ibm.com>
	<20070515105837.204d080f.sfr@canb.auug.org.au>
	<1179191003.3420.78.camel@zod.rchland.ibm.com>
	<20070515120321.8385a60f.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Mon, 14 May 2007 21:42:52 -0500
Message-Id: <1179196972.3420.100.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-05-15 at 12:03 +1000, Stephen Rothwell wrote:
> On Mon, 14 May 2007 20:03:23 -0500 Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:
> >
> > Wasn't by accident.  I was following the lead of what was done for
> > Ebony/440GP (which is actually broken at the moment but has a patch
> > pending to comment it out as above).
> >
> > There is no ethernet period without the new EMAC rewrite and I'd like to
> > leave the select there but commented out to serve as a placeholder if
> > nothing else.  Of course, if there are lots of objections it can be
> > pulled.
> 
> Sorry, I misunderstood. That's fine.

Thanks Stephen.  I can see how it would be misleading without some sort
of explanation.  I'll be sure to note it in future revisions.

josh
