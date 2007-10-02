Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.180])
	by ozlabs.org (Postfix) with ESMTP id 1A8B9DDF6A
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 23:52:05 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so5291902wag
	for <linuxppc-dev@ozlabs.org>; Tue, 02 Oct 2007 06:52:04 -0700 (PDT)
Message-ID: <fa686aa40710020652u38a8ee1dj3e65ba1764de999e@mail.gmail.com>
Date: Tue, 2 Oct 2007 07:52:04 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jens Axboe" <jens.axboe@oracle.com>
Subject: Re: [PATCH v2 2/6] Sysace: Use the established platform bus api
In-Reply-To: <20071002063523.GM5303@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070930225112.2476.49914.stgit@trillian.cg.shawcable.net>
	<20070930225707.2476.24080.stgit@trillian.cg.shawcable.net>
	<20070930230557.GA17654@infradead.org>
	<fa686aa40709301633q32c7bd9epf07b5a78acb4380e@mail.gmail.com>
	<20071001115954.GD5303@kernel.dk> <1191304710.6310.97.camel@pasglop>
	<20071002063523.GM5303@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, paulus@samba.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/2/07, Jens Axboe <jens.axboe@oracle.com> wrote:
> On Tue, Oct 02 2007, Benjamin Herrenschmidt wrote:
> >
> > On Mon, 2007-10-01 at 13:59 +0200, Jens Axboe wrote:
> > > Just send a fixup patch for that, I'll add your series to the block tree
> > > for 2.6.24.
> >
> > It's actually better off living in the powerpc tree I think as it's
> > really about adding support for a new powerpc platform and somewhat
> > needs to sync with other things in there. Unless you really want the
> > whole thing in your tree :-)
>
> I already included it yesterday, it'll go up once 2.6.24 opens. Let me
> know if you want me to rip it out, though.

No, it's safe.  Nothing will break if one goes in before the other.
Please keep it in.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
