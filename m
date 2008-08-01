Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 67790DE277
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Aug 2008 01:59:02 +1000 (EST)
Date: Fri, 1 Aug 2008 11:59:01 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Subject: Re: platforms/44x/warp-nand.c bogosity
Message-ID: <20080801115901.082491ba@lappy.seanm.ca>
In-Reply-To: <20080801112628.35fb0ff2@zod.rchland.ibm.com>
References: <20080801151401.GC24735@cs181140183.pp.htv.fi>
	<20080801112628.35fb0ff2@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Adrian Bunk <bunk@kernel.org>,
	Stefan Roese <sr@denx.de>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 1 Aug 2008 11:26:28 -0400
"Josh Boyer" <jwboyer@linux.vnet.ibm.com> wrote:

> I don't believe it is intentional, no.  Sean can you look at this and
> see what's up?  I have a couple of fixes to queue up from you already
> and if you can get this one done in the next few days I'll included it
> as well.

So I went back in the archives. Somebody else, Thomas Gleixner I
believe, was already working on the ndfc port. So, since I *had* to
have a working ndfc, I put a local copy in my kernel and forgot about
it.

It looks like Thomas has dropped the port. I should probably resubmit
the patch with the arch/ppc code removed. However, I don't think this
would be for 2.6.27 timeframe since there will probably be discussion.
For one, my patch just gets it working... the warp-nand.c file shows
that it is not a complete solution ;) Second, there are some byte order
issues.

So could we just leave warp-nand.c "there but disabled" for now?

Cheers,
   Sean
