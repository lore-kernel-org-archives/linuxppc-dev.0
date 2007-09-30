Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.236])
	by ozlabs.org (Postfix) with ESMTP id 55845DDE06
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Oct 2007 09:33:58 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so2345703nzh
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Sep 2007 16:33:56 -0700 (PDT)
Message-ID: <fa686aa40709301633q32c7bd9epf07b5a78acb4380e@mail.gmail.com>
Date: Sun, 30 Sep 2007 17:33:55 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Christoph Hellwig" <hch@infradead.org>,
	"Grant Likely" <grant.likely@secretlab.ca>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	paulus@samba.org, axboe@kernel.dk
Subject: Re: [PATCH v2 2/6] Sysace: Use the established platform bus api
In-Reply-To: <20070930230557.GA17654@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070930225112.2476.49914.stgit@trillian.cg.shawcable.net>
	<20070930225707.2476.24080.stgit@trillian.cg.shawcable.net>
	<20070930230557.GA17654@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 9/30/07, Christoph Hellwig <hch@infradead.org> wrote:
> On Sun, Sep 30, 2007 at 04:57:09PM -0600, Grant Likely wrote:
> > +     if ((rc = platform_driver_register(&ace_platform_driver)) != 0)
> > +             goto err_plat;
>
>         rc = platform_driver_register(&ace_platform_driver);
>         if (rc)
>                  goto err_plat;
>
> please.

Okay, will do.

>
> > +      err_plat:
> > +     unregister_blkdev(ace_major, "xsysace");
> > +      err_blk:
>
> labels should be indented zero or one space, but not more.

scripts/Lindent does this.  Originally, I *didn't* have my labels
indented.  :-)   Does Lindent need to be fixed?

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
