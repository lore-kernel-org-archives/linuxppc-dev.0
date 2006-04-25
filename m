Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4D53167A3F
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2006 04:49:00 +1000 (EST)
Date: Tue, 25 Apr 2006 11:48:57 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Brent Cook <bcook@bpointsys.com>
Subject: Re: 85xx FDT updates?
Message-ID: <20060425184857.GB1132@gate.ebshome.net>
References: <4C61B597-BD91-4D05-BB40-43DE0319F123@kernel.crashing.org>
	<265F73F8-F641-4EDD-B88F-A2B2F7FA1308@kernel.crashing.org>
	<20060425182418.GA1132@gate.ebshome.net>
	<200604251329.35584.bcook@bpointsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200604251329.35584.bcook@bpointsys.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 25, 2006 at 01:29:34PM -0500, Brent Cook wrote:
> On Tuesday 25 April 2006 13:24, Eugene Surovegin wrote:
> > On Tue, Apr 25, 2006 at 01:14:55PM -0500, Kumar Gala wrote:
> > > >What you will end up with is that that small amount of embedded people
> > > >who bother to contribute something back will stop doing this. We are
> > > >more than capable of maintaining our internal kernel trees :).
> > >
> > > I'm not sure what to say to this.  Things need to move forward at
> > > some point.
> >
> > I don't see how removing features and breaking compatibility with
> > almost _all_ current embedded PPC boards boards is "moving forward".
> > Enlighten me, please.
> >
> > > I still not clear as to what exactly you are advocating
> > > beyond that we should keep the arch/ppc code around for ever.
> >
> > Providing compatibility for non-flat-tree firmware. This doesn't mean
> > keeping arch/ppc.
> 
> Would it be possible to create the device tree in the kernel and then jump 
> into the normal entry point? We need some sort of translation shim between 
> the normal kernel and whatever oddball method firmware X chooses to hand-off 
> to the kernel.

Yes. This was suggested numerous number of times. Kumar, for some 
reason which I don't understand, keeps ignoring this.

And yes, I think person who breaks compatibility is the one who should 
be doing this work :).

-- 
