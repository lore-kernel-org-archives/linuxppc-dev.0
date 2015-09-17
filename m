Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E84D21A0024
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2015 21:01:37 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Geoff Levand <geoff@infradead.org>
Subject: Re: Time to remove platforms/cell?
Date: Thu, 17 Sep 2015 13:01:24 +0200
Message-ID: <1927138.LdVrYNaHMk@wuerfel>
In-Reply-To: <1442484325.26748.7.camel@ellerman.id.au>
References: <1442467727.25483.0.camel@ellerman.id.au>
 <7144823.dIR0EDXkmx@wuerfel> <1442484325.26748.7.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 17 September 2015 20:05:25 Michael Ellerman wrote:
> On Thu, 2015-09-17 at 11:31 +0200, Arnd Bergmann wrote:
> > b) Support for IBM blades:
> >    It is unlikely that there are QS20 blades still around and being used
> >    at all, but there is very little code specific to them.
> 
> Wasn't spider QS20 only? So that would be a bit of code that could go,
> including (some of) the io-workarounds code (I think).

Spider is also used on PS3, so if anyone is still using that as bare-metal
(hacked) rather than OtherOS mode, it would be needed. Don't know if we
ever supported that upstream though.

> >    For QS21/QS22, there are probably still a few in existence, but
> >    I have no idea whether anybody would consider running a 4.x kernel
> >    on them. There are also some customer-specific Cell machines that
> >    are vaguely related to QS22 and that are in a similar state.
> >    I don't mind removing the code, but if anybody is still using it
> >    on new kernels, we should be prepared to put it back.
> 
> Yeah, that's my impression. We obviously still have a QS22, but really we're
> only keeping it alive for testing purposes.
> 
> Hopefully this email will bring some more folks out of the woodwork.

FWIW, the last data points from Mercury and Fixstars (who were both offering
OEM products based on QS2x) were from 2009. IBM officially stopped selling the
QS22 in January 2012, which is much later than what I remembered as the day
they stopped offering support.

	Arnd
