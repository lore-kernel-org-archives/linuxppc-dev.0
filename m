Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 2/4 v4] POWERPC: Add StorCenter DTS first draft. 
In-Reply-To: Your message of "Fri, 01 Feb 2008 18:50:33 +1100."
	<20080201075033.GB18684@localhost.localdomain>
References: <E1JHkYP-00010b-At@jdl.com>
	<20080201075033.GB18684@localhost.localdomain>
Date: Fri, 01 Feb 2008 08:34:54 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1JKwyk-0007fm-2u@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day David Gibson mumbled:
> > +/ {
> > +	model = "StorCenter";
> > +	compatible = "storcenter";
> 
> This really needs a vendor prefix.

Hey Grant!

Here's how dumb I am:  You were thinking "Something's wrong here..."
and kept saying "Needs a model name!", and I kept saying "That _is_
the model name!"  And finally Dave comes along and with the ever-obvious
"Needs a vendor prefix!"

I'm like, "D'oh!"

> > +	chosen {
> > +		linux,stdout-path = "/soc/serial@4500";
> 
> You can now use a path reference here.

Ah, good point.  I'll get around to an update patch!

Thanks!
jdl
