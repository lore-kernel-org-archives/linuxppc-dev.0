Return-Path: <bunk@kernel.org>
Received: from smtp5.pp.htv.fi (smtp5.pp.htv.fi [213.243.153.39])
	by ozlabs.org (Postfix) with ESMTP id 7CAD7DDEF9
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 22:01:51 +1000 (EST)
Date: Fri, 27 Jun 2008 14:59:37 +0300
From: Adrian Bunk <bunk@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 48/60] microblaze_v4: headers simple files - empty or
	redirect to asm-generic
Message-ID: <20080627115936.GA18644@cs181140183.pp.htv.fi>
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>
	<200806261838.33787.arnd@arndb.de>
	<20080626180530.GA22827@cs181140183.pp.htv.fi>
	<200806270123.06669.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <200806270123.06669.arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
	Michal Simek <monstr@monstr.eu>, vapier.adi@gmail.com,
	matthew@wil.cx, microblaze-uclinux@itee.uq.edu.au,
	linux-kernel@vger.kernel.org, drepper@redhat.com,
	linuxppc-dev@ozlabs.org, will.newton@gmail.com, hpa@zytor.com,
	monstr@seznam.cz, John.Linn@xilinx.com, john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jun 27, 2008 at 01:23:05AM +0200, Arnd Bergmann wrote:
> On Thursday 26 June 2008, Adrian Bunk wrote:
> > Honestly, I do not completely like your approach of getting the 
> > microblaze port submitter to create the asm-generic files - I would 
> > personally prefer if the microblaze port would look exactly like all 
> > other ports and the (reasonable) changes you have in mind were not
> > being discussed and done as part of the submission of a new port.
> 
> But it works really well this way ;-). My point is that a new port
> should look just like all the other ports should have looked as
> well, not like they did. When it comes to the ABI, you
> cannot make incompatible changes after it's merged, so IMHO all
> ABI defining headers should go to asm-generic if possible.
>...

For the ABI it doesn't matter where the headers are.

> > After all, it won't matter whether we'll unify resp. remove
> > 22 or 23 files.
> 
> That wasn't my idea. The logic was that if one more file exists
> in asm-generic that can be removed from the architectures,
> we get 22 more files to remove without anyone having to look
> at the big picture. When microblaze is in,

Discussions of the "big picture" should be in an own thread, not as 
part of a merge of a new architecture.

I am not an architecture maintainer, but I do not like the way you want 
to couple the microblaze merge with the move of stuff to asm-generic.

They both make sense, but they are clearly separate issues.

> I can compile a list
> with asm-generic files that can be used to replace the architecture
> specific files, so the arch maintainers can decide on their own
> whether to clean their own stuff up or not.
>...

We need either all architectures changed or none at all - we do need the 
arch headers to become more similar, not more different.

And this is why we need an agreement _before_ an asm-generic header gets 
added, not after it.

> 	Arnd <><

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
