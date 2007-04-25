Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 23042DDE06
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Apr 2007 11:12:36 +1000 (EST)
Subject: Re: [PATCH 3/6] Consolidate of_find_property
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <a8ef1d22d218c74620bc38ed9d35830e@kernel.crashing.org>
References: <20070403105217.7b9fea08.sfr@canb.auug.org.au>
	<20070403223000.5d44b2f1.sfr@canb.auug.org.au>
	<20070403223136.6ecdabbd.sfr@canb.auug.org.au>
	<20070403223257.cb8c4d15.sfr@canb.auug.org.au>
	<20070403223535.dd6731d6.sfr@canb.auug.org.au>
	<20070403223738.03386a13.sfr@canb.auug.org.au>
	<20070403223914.35bf04e1.sfr@canb.auug.org.au>
	<20070403224039.913af749.sfr@canb.auug.org.au>
	<20070403224205.807cffe0.sfr@canb.auug.org.au>
	<20070403224340.5533abc9.sfr@canb.auug.org.au>
	<20070403224505.5d5a1495.sfr@canb.auug.org.au>
	<20070403224610.b61c7377.sfr@canb.auug.org.au>
	<20070403224937.f6a07e56.sfr@canb.auug.org.au>
	<20070403225059.e735b5e4.sfr@canb.auug.org.au>
	<20070403225222.88e92221.sfr@canb.auug.org.au>
	<20070403230505.f96ea210.sfr@canb.auug.org.au>
	<20070403232406.ab9a3c86.sfr@canb.auug.org.au>
	<20070412141905.6f30efd3.sfr@canb.auug.org.au>
	<20070412153424.bf3957f4.sfr@canb.auug.org.au>
	<20070424223245.78f4fdfb.sfr@canb.auug.org.au>
	<20070424223930.1dab0e28.sfr@canb.auug .org.au>
	<1177459235.14873.155.camel@localhost.localdomain>
	<a8ef1d22d218c74620bc38ed9d35830e@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 25 Apr 2007 11:12:18 +1000
Message-Id: <1177463538.14873.179.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org,
	"David S. Miller" <davem@davemloft.net>,
	Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-04-25 at 02:43 +0200, Segher Boessenkool wrote:

> The OF standard doesn't allow upper case in property
> names at all.

Ok, fair enough, but in practice, they exist :-)

> > I don't think we would take much risk on ppc by
> > using strncasecmp but it shouldn't be necessary...
> 
> There are some examples where upper case is actually
> used in property names, unfortunately.  These can
> be solved by renaming/copying those properties to
> all lower case in a bootwrapper, or by strcmp() to
> the "cased" string, or by strcasecmp().  I for one
> don't like either option, you figure it out ;-)

Oh well, I don't care either way though fixup from bootwrapper doesn't
appeal to me at all...

Ben.
