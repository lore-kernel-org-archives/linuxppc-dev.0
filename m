Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <78325f65fc807da213be423c20ce6dcd@kernel.crashing.org>
References: <1116909286.4992.17.camel@gaston> <1116909351.4992.19.camel@gaston>
	<78325f65fc807da213be423c20ce6dcd@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 24 May 2005 17:55:02 +1000
Message-Id: <1116921302.6395.6.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc64-dev@ozlabs.org, Tzachi Perelstein <tzachi@marvell.com>,
	u-boot-users@lists.sourceforge.net,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: Booting the Linux/ppc64 kernel without Open Firmware HOWTO (v3)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2005-05-24 at 09:50 +0200, Segher Boessenkool wrote:
> > +/*
> > + * The Open Firmware 1275 specification states properties must be 31 
> > bytes or
> > + * less, however not all firmwares obey this. Make it 64 bytes to be 
> > safe.
> > + */
> 
> Not true.  There is no restriction on the length of properties
> (or property _names_, which I guess is what you meant). 

Yes, we meant names, and yes, there is a limit of 31 characters + 0,
that is 32 bytes (see "3.2.2.1.1 Property names" in 1275. BTW. Do you
have a useable version of this document ? mine is a totally broken PDF
made from a crappy .ps :)

IBM firmware broke that limit in a couple of places though...

>  There
> is the 31-char restriction on _node_ names, though (and the node
> name is only the part before the optional @ or : -- and at a
> minimum, the part after @ but before : is needed to disambiguate
> the node).

Yes, I know all that.

> I didn't review the rest of the code, sorry.

No worries :)

Ben.
