Return-Path: <amodra@bigpond.net.au>
Received: from qsrv01ps.mx.bigpond.com (qsrv01ps.mx.bigpond.com
	[144.140.82.181]) by ozlabs.org (Postfix) with ESMTP id D2DF367B67
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Aug 2006 16:27:29 +1000 (EST)
Date: Wed, 16 Aug 2006 15:39:12 +0930
From: Alan Modra <amodra@bigpond.net.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [POWERPC] iseries: remove some gcc 4.1 warnings
Message-ID: <20060816060912.GA6821@bubble.grove.modra.org>
References: <20060816152032.2407a832.sfr@canb.auug.org.au>
	<1155705964.12715.8.camel@localhost.localdomain>
	<20060816153206.5bd2d64e.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060816153206.5bd2d64e.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 16, 2006 at 03:32:06PM +1000, Stephen Rothwell wrote:
> On Wed, 16 Aug 2006 15:26:04 +1000 Michael Ellerman <michael@ellerman.id.au> wrote:
> >
> > On Wed, 2006-08-16 at 15:20 +1000, Stephen Rothwell wrote:
> > > gcc 4.1 produces some warnings that it is ignoring the packed attribute
> > > on some structure elements, so just remove them.
> > 
> > Why is it ignoring them? Because there's no packing to be done?
> 
> A patch went into gcc to warn if the thing you are packing is already
> minimally aligned.  I have not idea why it warns ...

http://gcc.gnu.org/ml/gcc-patches/2005-11/msg01883.html
http://gcc.gnu.org/bugzilla/show_bug.cgi?id=21166

-- 
Alan Modra
IBM OzLabs - Linux Technology Centre
