Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 63A59DDF9B
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 03:06:01 +1100 (EST)
Date: Tue, 18 Dec 2007 10:12:08 -0600
From: Olof Johansson <olof@lixom.net>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Raising list size limit
Message-ID: <20071218161208.GA7495@lixom.net>
References: <20071218143627.94f76142.sfr@canb.auug.org.au>
	<20071218060105.368f0bd4@zod.rchland.ibm.com>
	<2420E261-C9AB-49B8-8F99-C24C7A865044@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2420E261-C9AB-49B8-8F99-C24C7A865044@kernel.crashing.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Dec 18, 2007 at 09:54:15AM -0600, Kumar Gala wrote:
> 
> On Dec 18, 2007, at 6:01 AM, Josh Boyer wrote:
> 
> > On Tue, 18 Dec 2007 14:36:27 +1100
> > Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> >> Hi,
> >>
> >> I am considering raising the limit on the size of postings to  
> >> 400k.  Does
> >> anyone have a real problem with this?  Limiting message size was  
> >> done to
> >> limit the damage of larges spams (and we don;t get very many of  
> >> those on
> >> the list) and to ease the pain for people downloading emails over a  
> >> slow
> >> (like dialup) link (and are there many of those left?).
> >
> > Fine by me!
> 
> Do you really have patches that are 400k?

I'm guessing stuff such as "dtc merge" could reach those sizes?

Since it's somewhat common to cross-post patches (especially some of the
@de.ibm.com guys seem to post to 2-5 lists at a time), having a limit
higher than other lists could mean we see the same (large) patches several
times in case they bounce from other lists and get reposted. But it should
be a small fraction of the traffic no matter what.


-Olof
