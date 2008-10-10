Return-Path: <lethal@linux-sh.org>
Received: from mx.gate01.com (mta23.gyao.ne.jp [125.63.38.249])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0533BDE000
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Oct 2008 04:28:43 +1100 (EST)
Date: Sat, 11 Oct 2008 02:28:37 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: [RFC 0/6] Proposal for a Generic PWM Device API
Message-ID: <20081010172837.GB10579@linux-sh.org>
References: <cover.1223482372.git.bgat@billgatliff.com>
	<1223608819.8157.127.camel@pasglop>
	<48EED4D1.2040506@billgatliff.com>
	<Pine.LNX.4.64.0810101054140.12257@vixen.sonytel.be>
	<20081010093642.GA10579@linux-sh.org>
	<48EF60B6.20409@billgatliff.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48EF60B6.20409@billgatliff.com>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	linux-embedded@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 10, 2008 at 09:03:34AM -0500, Bill Gatliff wrote:
> Paul Mundt wrote:
> > This is likely because some of those lists are subscribers only, so cross
> > posting is poor form. It makes sense to keep the discussion in one place,
> > and to send notification messages with a pointer to the list archives to
> > the other lists so folks can jump in if they really care. Splitting it
> > out doesn't help matters in the least, but unfortunately this is what
> > seems to happen the most when subscribers only lists are involved.
> 
> Alright, then maybe I can do this when I post the "final" changeset for review:
> cross-post to lkml and linux-embedded, and then post one short note on l-a-k,
> linuxppc-dev and elsewhere that refers those interested to the actual content.
> I can live with that.
> 
linux-arm-kernel is the only one that is subscribers only out of that
list, according to MAINTAINERS. If rmk wants to mandate a broken policy,
that's perfectly fine, just don't expect the rest of the kernel community
to tolerate it.
