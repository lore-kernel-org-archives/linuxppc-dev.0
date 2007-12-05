Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3A1F8DDDE9
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Dec 2007 05:05:51 +1100 (EST)
Date: Wed, 5 Dec 2007 21:05:36 +0300
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH] Add aliases node to 8641hpcn DTS file.
Message-ID: <20071205210536.41158b6b@kernel.crashing.org>
In-Reply-To: <fa686aa40712050938j2d286655o94534a00131872e2@mail.gmail.com>
References: <1196875970.8544.12.camel@ld0161-tx32>
	<fa686aa40712050938j2d286655o94534a00131872e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 5 Dec 2007 10:38:38 -0700
Grant Likely wrote:

> >
> > +       aliases {
> > +               ethernet0 = &enet0;
> > +               ethernet1 = &enet1;
> > +               ethernet2 = &enet2;
> > +               ethernet3 = &enet3;
> > +               serial0 = &serial0;
> > +               serial1 = &serial1;
> > +               pci0 = &pci0;
> > +               pci1 = &pci1;
> > +       };  
> 
> I had thought aliases were supposed to be full paths to nodes instead
> of phandles.  Was I wrong?
no, but dwg did a patch for dtc to do that dirty work for you, resolving labels. I am also curious if such a change made it in
dtc git (working with full path aliases now). dtc should prolly get tagged and next sub-rev to be clear if it supports aliases or not.

-- 
Sincerely, Vitaly
