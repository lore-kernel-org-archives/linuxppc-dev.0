Return-Path: <Haavard.Skinnemoen@atmel.com>
Received: from bagnes.atmel.com (smtpeu1.atmel.com [195.65.72.27])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7DE09DE10F
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Oct 2008 02:06:39 +1100 (EST)
Date: Fri, 10 Oct 2008 16:32:45 +0200
From: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
To: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: [RFC 0/6] Proposal for a Generic PWM Device API
Message-ID: <20081010163245.3c2f0240@hskinnemo-gx745.norway.atmel.com>
In-Reply-To: <48EF60B6.20409@billgatliff.com>
References: <cover.1223482372.git.bgat@billgatliff.com>
	<1223608819.8157.127.camel@pasglop>
	<48EED4D1.2040506@billgatliff.com>
	<Pine.LNX.4.64.0810101054140.12257@vixen.sonytel.be>
	<20081010093642.GA10579@linux-sh.org>
	<48EF60B6.20409@billgatliff.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, Linux/PPC,
	Paul Mundt <lethal@linux-sh.org>, linux-embedded@vger.kernel.org,
	Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Bill Gatliff <bgat@billgatliff.com> wrote:
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

Feel free to cross-post to kernel@avr32linux.org. It's open for
non-subscribers, and there may be people interested in PWM there
(especially since you include a driver for the PWM hardware on AVR32
devices.)

Haavard
