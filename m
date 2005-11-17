Return-Path: <peterh@google.com>
Received: from smtp-out.google.com (smtp-out.google.com [216.239.45.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4CE5568786
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Nov 2005 10:05:17 +1100 (EST)
Received: from brian.corp.google.com (brian.corp.google.com [172.24.0.122])
	by smtp-out.google.com with ESMTP id jAHN5Epa000406
	for <linuxppc-embedded@ozlabs.org>; Thu, 17 Nov 2005 15:05:14 -0800
Received: from smtp-out2.google.com (fpx22.prod.google.com [10.253.24.22])
	by brian.corp.google.com with ESMTP id jAHN4rCV025403
	for <linuxppc-embedded@ozlabs.org>; Thu, 17 Nov 2005 15:05:13 -0800
Received: by smtp-out2.google.com with SMTP id 22so326481fpx
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Nov 2005 15:05:13 -0800 (PST)
Message-ID: <50e923300511171505t5f4858c3sfb60086f50e402dd@mail.google.com>
Date: Thu, 17 Nov 2005 15:05:13 -0800
From: Peter Hanson <peterh@google.com>
To: Greg KH <greg@kroah.com>
In-Reply-To: <20051117174912.GA23034@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20051115175955.GA14518@kroah.com>
	<Pine.LNX.4.44.0511151332310.28098-100000@gate.crashing.org>
	<20051115224056.GA14357@kroah.com>
	<50e923300511161839g12ad1e88je46f989192cd3f58@mail.google.com>
	<20051117041645.GA19145@kroah.com>
	<50e923300511170951o5695e3f2s8b4b7ae4c1f8788a@mail.google.com>
	<20051117174912.GA23034@kroah.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Platform device model drawback
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 11/17/05, Greg KH <greg@kroah.com> wrote:
> On Thu, Nov 17, 2005 at 09:51:56AM -0800, Peter Hanson wrote:
> > On 11/16/05, Greg KH <greg@kroah.com> wrote:
> > > On Wed, Nov 16, 2005 at 06:39:49PM -0800, Peter Hanson wrote:
> > > > IIRC, Arabella claims to deal nicely with dynamic allocation of
> > > > PowerPC resources to Linux devices =3D>
> > > > http://www.arabellasw.com/home.php
> > >
> > > I don't understand how that pertains to this thread...
> >
> > Potential conflict: multiple logical devices competing for the same
> > SoC resource.  Converse: similar logical devices supported by
> > different resources.  Both cases have been mentioned in this thread,
> > with confusion about how to deal with them.
> >
> > Does Arabella solve it as claimed?  I don't know.  But dynamic
> > allocation doesn't sound crazy.  Maybe some of the code or design can
> > even be copied.
>
> Do you have a pointer to their code anywhere?

I checked [http://www.arabellasw.com/products-free.php], and the
downloadable source is now gone.  :-(

> thanks,
>
> greg k-h
