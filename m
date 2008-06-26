Return-Path: <bunk@kernel.org>
Received: from smtp4.pp.htv.fi (smtp4.pp.htv.fi [213.243.153.38])
	by ozlabs.org (Postfix) with ESMTP id 5CF0CDECEC
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 04:07:41 +1000 (EST)
Date: Thu, 26 Jun 2008 21:05:30 +0300
From: Adrian Bunk <bunk@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 48/60] microblaze_v4: headers simple files - empty or
	redirect to asm-generic
Message-ID: <20080626180530.GA22827@cs181140183.pp.htv.fi>
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>
	<200806261735.12738.arnd@arndb.de>
	<20080626162118.GG22025@cs181140183.pp.htv.fi>
	<200806261838.33787.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <200806261838.33787.arnd@arndb.de>
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

On Thu, Jun 26, 2008 at 06:38:32PM +0200, Arnd Bergmann wrote:
> On Thursday 26 June 2008, Adrian Bunk wrote:
> > The comment could be nuked (as well as the #ifdef __KERNEL__), but for 
> > the one #define an asm-generic header would IMHO be overkill.
> 
> I agree that it doesn't technically make sense to have a one-line
> asm-generic header, but I like the idea of reducing the number of
> asm/*.h files that actually contain anything other that
> #include <asm-generic/$FILE.h>, mostly for documentation purposes.
> 
> If we can eventually agree on a way to get rid of the requirement
> for explicit redirection, we can remove a larger number of source
> files completely.

Honestly, I do not completely like your approach of getting the 
microblaze port submitter to create the asm-generic files - I would 
personally prefer if the microblaze port would look exactly like all 
other ports and the (reasonable) changes you have in mind were not
being discussed and done as part of the submission of a new port.

After all, it won't matter whether we'll unify resp. remove
22 or 23 files.

> 	Arnd <><

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
