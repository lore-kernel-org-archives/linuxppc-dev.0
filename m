Return-Path: <lethal@linux-sh.org>
Received: from mx.gate01.com (mta23.gyao.ne.jp [125.63.38.249])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1A6B3DDE28
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 20:53:14 +1100 (EST)
Date: Fri, 10 Oct 2008 18:36:42 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [RFC 0/6] Proposal for a Generic PWM Device API
Message-ID: <20081010093642.GA10579@linux-sh.org>
References: <cover.1223482372.git.bgat@billgatliff.com>
	<1223608819.8157.127.camel@pasglop>
	<48EED4D1.2040506@billgatliff.com>
	<Pine.LNX.4.64.0810101054140.12257@vixen.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0810101054140.12257@vixen.sonytel.be>
Cc: Bill Gatliff <bgat@billgatliff.com>, linux-embedded@vger.kernel.org,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 10, 2008 at 11:00:09AM +0200, Geert Uytterhoeven wrote:
> On Thu, 9 Oct 2008, Bill Gatliff wrote:
> > Benjamin Herrenschmidt wrote:
> > > On Wed, 2008-10-08 at 11:43 -0500, Bill Gatliff wrote:
> > >> This series proposes a "generic PWM" driver API.
> > >>
> > >> This proposed API is motivated by the author's need to support
> > >> pluggable devices; a secondary objective is to consolidate the
> > >> existing PWM implementations behind an agreeable, consistent,
> > >> redundancy-reducing interface.
> > > 
> > >  .../...
> > > 
> > > You should send your patches to the main linux kernel list !
> > 
> > Perhaps.  But it seemed more relevant to this crowd, and the linux-embedded
> > crowd, and the linux-arm-kernel crowd.
> 
> Were did you actually sent them to?  Apparently you sent them to each mailing
> list (at least linux-embedded and linuxppc-dev) _separately_ (or using bcc).
> 
> Hence different people may give the same comments without knowing about each
> other, and you may have to explain everything multiple times.
> 
> I would go for lkml and linux-embedded, _together_.
> 
This is likely because some of those lists are subscribers only, so cross
posting is poor form. It makes sense to keep the discussion in one place,
and to send notification messages with a pointer to the list archives to
the other lists so folks can jump in if they really care. Splitting it
out doesn't help matters in the least, but unfortunately this is what
seems to happen the most when subscribers only lists are involved.
