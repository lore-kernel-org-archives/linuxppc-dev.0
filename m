Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id BAF83DDE07
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Dec 2008 07:49:18 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Lee Schermerhorn <Lee.Schermerhorn@hp.com>
Subject: Re: [PATCH] numactl: fix libnuma on big-endian 64-bit systems
Date: Thu, 4 Dec 2008 21:49:05 +0100
References: <200812041834.45931.arnd@arndb.de>
	<1228412816.6959.48.camel@lts-notebook>
In-Reply-To: <1228412816.6959.48.camel@lts-notebook>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200812042149.06163.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Mijo Safradin <safradin@de.ibm.com>,
	Cliff Wickman <cpw@sgi.com>, Christoph Lameter <clameter@sgi.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 04 December 2008, Lee Schermerhorn wrote:
> On Thu, 2008-12-04 at 18:34 +0100, Arnd Bergmann wrote:
> > The read-mask function assumes that it is running in 32-bit mode,
> > by addressing the bitmask as a series of int values, instead of
> > longs. This is broken as can easily be reproduced by running numademo
> > on a bit-endian 64-bit system.
> > 
> > Changing the addressing to use 'long' values fixes the problem.
> 
> Hi, Arnd:
> 
> Not sure what you mean here.  If the patch below is a proposed fix [I
> don't see a 'Signed-off-by:", but maybe not needed for libnuma
> patches?], the description above doesn't match the code.  Looks like
> you're changing the addressing FROM 'long' values to use 'int' values so
> that the size is compatible between 32- and 64-bits.  Or is that a
> reverse patch/diff below?

Sorry about that, I was in a hurry when sending this one out and attached
the wrong file, the reverse patch is needed indeed. I'll resend with
a proper Signed-off-by.

	Arnd <><
