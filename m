Return-Path: <greg@kroah.com>
Received: from perch.kroah.org (mail.kroah.org [69.55.234.183])
	by ozlabs.org (Postfix) with ESMTP id 8407F68734
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Nov 2005 05:08:54 +1100 (EST)
Date: Thu, 17 Nov 2005 09:49:12 -0800
From: Greg KH <greg@kroah.com>
To: Peter Hanson <peterh@google.com>
Message-ID: <20051117174912.GA23034@kroah.com>
References: <20051115175955.GA14518@kroah.com>
	<Pine.LNX.4.44.0511151332310.28098-100000@gate.crashing.org>
	<20051115224056.GA14357@kroah.com>
	<50e923300511161839g12ad1e88je46f989192cd3f58@mail.google.com>
	<20051117041645.GA19145@kroah.com>
	<50e923300511170951o5695e3f2s8b4b7ae4c1f8788a@mail.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <50e923300511170951o5695e3f2s8b4b7ae4c1f8788a@mail.google.com>
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

On Thu, Nov 17, 2005 at 09:51:56AM -0800, Peter Hanson wrote:
> On 11/16/05, Greg KH <greg@kroah.com> wrote:
> > On Wed, Nov 16, 2005 at 06:39:49PM -0800, Peter Hanson wrote:
> > > IIRC, Arabella claims to deal nicely with dynamic allocation of
> > > PowerPC resources to Linux devices =>
> > > http://www.arabellasw.com/home.php
> >
> > I don't understand how that pertains to this thread...
> 
> Potential conflict: multiple logical devices competing for the same
> SoC resource.  Converse: similar logical devices supported by
> different resources.  Both cases have been mentioned in this thread,
> with confusion about how to deal with them.
> 
> Does Arabella solve it as claimed?  I don't know.  But dynamic
> allocation doesn't sound crazy.  Maybe some of the code or design can
> even be copied.

Do you have a pointer to their code anywhere?

thanks,

greg k-h
