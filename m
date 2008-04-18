Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by ozlabs.org (Postfix) with ESMTP id 2BF2EDE4BB
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 08:53:17 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so197346anc.78
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 15:53:08 -0700 (PDT)
Message-ID: <fa686aa40804181553q622b3c1fi7a302712abe79be1@mail.gmail.com>
Date: Fri, 18 Apr 2008 16:53:08 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Matt Sealey" <matt@genesi-usa.com>
Subject: Re: RFC: MPC5200 PSC AC97 driver
In-Reply-To: <4808E469.9020408@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47FDEF9B.5000506@semihalf.com>
	<200804171619.56615.jbe@pengutronix.de>
	<4808C1BE.1050607@fang.fa.gau.hu>
	<200804181802.34833.jbe@pengutronix.de>
	<4808E469.9020408@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 18, 2008 at 12:11 PM, Matt Sealey <matt@genesi-usa.com> wrote:
>
>  Juergen Beisert wrote:
>
> >
> > On Friday 18 April 2008 17:43, Peter Czanik wrote:
> >
> > I'm not sure if "cell-index" is a correct property. I copied it from the
> uart driver, because this driver needs something to distinguish between PSC1
> and PSC2. Maybe there is a better and correct oftree solution? Any oftree
> expert here?
> >
>
>  cell-index is correct by legacy, but I think it has been said by that you
> could
>  just as well pick which PSC you are running on by it's address.
>
>  I would prefer the address approach, but everyone's going to keep
> cell-index
>  around anyway so why not leave it there and why not keep using it?

I was the one who started using cell-index in the first place; but
I've had a change of opinion and I think doing it by address would be
better.  That being said, it doesn't hurt to have the cell-index
property in there.  If/when we rework the drivers to use address, then
it will just be a harmless and superfluous property.

BTW, is anyone trying to shepherd this driver into the ALSA tree?  Its
out of my area of expertise and responsibility, so I haven't been
pursuing it.

Cheers,
g.
>
>
>  --
>  Matt Sealey <matt@genesi-usa.com>
>  Genesi, Manager, Developer Relations
>
>  _______________________________________________
>
>  Linuxppc-dev mailing list
>  Linuxppc-dev@ozlabs.org
>  https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
