Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.182])
	by ozlabs.org (Postfix) with ESMTP id 104EADDE02
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Oct 2007 23:17:07 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so4831388wag
	for <linuxppc-dev@ozlabs.org>; Mon, 01 Oct 2007 06:17:06 -0700 (PDT)
Message-ID: <fa686aa40710010617r1c28bef7u41f7da749c361bcb@mail.gmail.com>
Date: Mon, 1 Oct 2007 07:17:06 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jens Axboe" <jens.axboe@oracle.com>
Subject: Re: [PATCH v2 2/6] Sysace: Use the established platform bus api
In-Reply-To: <20071001115954.GD5303@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070930225112.2476.49914.stgit@trillian.cg.shawcable.net>
	<20070930225707.2476.24080.stgit@trillian.cg.shawcable.net>
	<20070930230557.GA17654@infradead.org>
	<fa686aa40709301633q32c7bd9epf07b5a78acb4380e@mail.gmail.com>
	<20071001115954.GD5303@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, linuxppc-dev@ozlabs.org,
	paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/1/07, Jens Axboe <jens.axboe@oracle.com> wrote:
> On Sun, Sep 30 2007, Grant Likely wrote:
> > On 9/30/07, Christoph Hellwig <hch@infradead.org> wrote:
> > > On Sun, Sep 30, 2007 at 04:57:09PM -0600, Grant Likely wrote:
> > > > +     if ((rc = platform_driver_register(&ace_platform_driver)) != 0)
> > > > +             goto err_plat;
> > >
> > >         rc = platform_driver_register(&ace_platform_driver);
> > >         if (rc)
> > >                  goto err_plat;
> > >
> > > please.
> >
> > Okay, will do.
> >
> > >
> > > > +      err_plat:
> > > > +     unregister_blkdev(ace_major, "xsysace");
> > > > +      err_blk:
> > >
> > > labels should be indented zero or one space, but not more.
> >
> > scripts/Lindent does this.  Originally, I *didn't* have my labels
> > indented.  :-)   Does Lindent need to be fixed?
>
> Seems so, if it idents labels.
>
> Just send a fixup patch for that, I'll add your series to the block tree
> for 2.6.24.

Cool, thanks Jens.  I'll generate a patch to unindent the labels this afternoon.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
