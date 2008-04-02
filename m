Return-Path: <benh@ozlabs.org>
Subject: Re: [PATCH 0/4] [POWERPC] lockdep support for ppc64
From: Benjamin Herrenschmidt <benh@ozlabs.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1207129830.10910.25.camel@johannes.berg>
References: <1207122728.672673.111194574046.qpush@grosgo>
	<1207129830.10910.25.camel@johannes.berg>
Content-Type: text/plain
Date: Wed, 02 Apr 2008 22:02:07 +1100
Message-Id: <1207134128.10388.254.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-04-02 at 11:50 +0200, Johannes Berg wrote:
> > This serie of patches adds lockdep support for 64 bits
> > powerpc. Dale's patch for 32 bits still need me to review
> > and test it which I'll try to do asap.
> 
> Yay. I'll give it another try later today.

Haven't tested this version on G5 yet btw :-) (though I had a previous
one working internally). I tested on POWER6 pSeries and old iSeries
(spent a while fixing the later).

I'll run more tests tomorrow hopefully and add a few patch fixing
some of the issues that lockdep already starting showing.

Cheers,
Ben.
