Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.180])
	by ozlabs.org (Postfix) with ESMTP id 9D718DDDEB
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Nov 2007 13:18:10 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so21812wag
	for <linuxppc-dev@ozlabs.org>; Wed, 07 Nov 2007 18:18:09 -0800 (PST)
Message-ID: <9e4733910711071818r23f2f739n6edbba3e0576870a@mail.gmail.com>
Date: Wed, 7 Nov 2007 21:18:09 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Stephen Rothwell" <sfr@canb.auug.org.au>
Subject: Re: [RFC] Modifying i2c-core to support alias driver names compatible
	with device trees
In-Reply-To: <20071108120535.769e4d73.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910711061239g22b06863rbec37fcef138c869@mail.gmail.com>
	<20071108120535.769e4d73.sfr@canb.auug.org.au>
Cc: Jean Delvare <khali@linux-fr.org>, Tjernlund <tjernlund@tjernlund.se>,
	i2c@lm-sensors.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/7/07, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> On Tue, 6 Nov 2007 15:39:42 -0500 "Jon Smirl" <jonsmirl@gmail.com> wrote:
> >
> > It was requested to split this code out into a separate thread....
> >
> > This code modifies the i2c-core to support lists of alias names in the
> > chip drivers.
> > For example: .aliases = (char const
> > *[]){"ricoh,rs5c372a","ricoh,rs5c372b","ricoh,rv5c386","ricoh,rv5c387a",
> > 0},
>
> You should not need the (char const *[]) casts at all.

That is what I thought but the compiler complains without it. I tried
everything I could think of to get rid of it.

-- 
Jon Smirl
jonsmirl@gmail.com
