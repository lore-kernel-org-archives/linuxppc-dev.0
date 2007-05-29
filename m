Return-Path: <rob@landley.net>
Received: from grelber.thyrsus.com
	(static-71-162-243-5.phlapa.fios.verizon.net [71.162.243.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0DD19DE056
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 07:16:56 +1000 (EST)
From: Rob Landley <rob@landley.net>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: Porting "prep" from ppc to powerpc.
Date: Tue, 29 May 2007 17:16:52 -0400
References: <200705252238.39819.rob@landley.net>
	<20070527232055.GA23768@localhost.localdomain>
In-Reply-To: <20070527232055.GA23768@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705291716.53090.rob@landley.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 27 May 2007 7:20 pm, David Gibson wrote:
> On Fri, May 25, 2007 at 10:38:39PM -0400, Rob Landley wrote:
> > Is anyone already doing this?  I asked around here a few weeks ago and got 
the 
> > advice:
> > 
> > > In theory.. copy the files from ppc/platforms/prep.* to
> > > powerpc/platforms/prep/ 
> > > and make some Kconfigs and see what breaks :)
> 
> Actually, I don't really recommend that method in any case.
> 
> Instead I suggest making a Kconfig under arch/powerpc, then adding
> things until it builds, then adding things until it boots.  When you
> need to know what has to be done at a particular point, consult
> arch/ppc.

So study the old code until I figure out what should be in the Kconfig, 
what "things" to add for it to build, and what "things" to add until it 
boots.  And the hint as to where to start is...  study the old code.

Right.  Copying the old implementation to the new directory and debugging it 
sounded like something I might be able to do.  Starting from scratch?  Not so 
much.

Rob
