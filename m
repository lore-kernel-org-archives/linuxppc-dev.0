Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CEDDDB6F7C
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 20 Apr 2011 13:07:45 +1000 (EST)
Subject: Re: [PATCH] cxgb4: use pgprot_writecombine() on powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nishanth Aravamudan <nacc@us.ibm.com>
In-Reply-To: <20110415172716.GA5881@us.ibm.com>
References: <1300134971-16752-1-git-send-email-nacc@us.ibm.com>
	<4D7E7FCE.3000703@opengridcomputing.com>
	<20110415172716.GA5881@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 20 Apr 2011 13:07:35 +1000
Message-ID: <1303268855.2513.22.camel@pasglop>
Mime-Version: 1.0
Cc: Steve Wise <swise@opengridcomputing.com>, linuxppc-dev@lists.ozlabs.org,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> > >Given that this depends on a patch in Ben's tree, should this go in via
> > >the powerpc tree? Presuming Steve acks it, of course.
> > >
> > >  drivers/infiniband/hw/cxgb4/t4.h |    5 +----
> > >  1 files changed, 1 insertions(+), 4 deletions(-)
> > >
> > 
> > Acked-by: Steve Wise <swise@opengridcomputing.com>
> > 
> > I suppose it should go into the same tree with the commit that adds this function.
> 
> Ben, I don't think this is in your tree yet, will you be taking it?

Thanks Steve. Yes, I'll put this in powerpc-next.

Cheers,
Ben.
