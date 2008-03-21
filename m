Return-Path: <jwboyer@gmail.com>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.244])
	by ozlabs.org (Postfix) with ESMTP id 464DBDE0BD
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 23:24:26 +1100 (EST)
Received: by hs-out-0708.google.com with SMTP id z77so1374207hsz.9
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 05:24:24 -0700 (PDT)
Date: Fri, 21 Mar 2008 07:24:19 -0500
From: Josh Boyer <jwboyer@gmail.com>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] [POWERPC] Add AMCC Glacier 460GT eval board dts
Message-ID: <20080321072419.2372774b@hansolo.jdub.homelinux.org>
In-Reply-To: <200803211154.34027.sr@denx.de>
References: <1205943310-26323-1-git-send-email-sr@denx.de>
	<1206090031.8420.67.camel@pasglop> <200803211154.34027.sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 21 Mar 2008 11:54:33 +0100
Stefan Roese <sr@denx.de> wrote:

> On Friday 21 March 2008, Benjamin Herrenschmidt wrote:
> > On Wed, 2008-03-19 at 17:15 +0100, Stefan Roese wrote:
> > > +               cpu@0 {
> > > +                       device_type = "cpu";
> > > +                       model = "PowerPC,460GT";
> > > +                       reg = <0>;
> >
> > I wonder if we should do something here to differenciate the SoC chip
> > from the core. After all, all those 4xx mostly have the same core (there
> > are 2 or 3 revisions of the core maybe ...) but they tend to have all
> > different PVR which is a pain and won't scale...
> >
> > Maybe AMCC could do something in HW (splitting the PVR from whatever
> > indicates what "chip" it is, and keeping the PVR purely for the core
> > rev) but I'm wondering if we should also do something in the DTS..
> > Stefan can you talk to your AMCC contacts about this ?
> 
> Yes, I'll do that. Not sure about the outcome though.
> 
> > As for the DTS, maybe a "compatible" property in the CPU might make some
> > sense with a content along the lines of "ppc440x6" or whatever rev of
> > the 440 core it is.
> >
> > What do you think ?
> 
> Good idea. I'll try to come up with a list for all existing 4xx SoC's and it's 
> core versions.

I don't really care either way, but what does that buy us?  Merely
documentation?

josh
