Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A73E02BDB3
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Oct 2004 03:20:12 +1000 (EST)
In-Reply-To: <20041008164047.GC14773@smtp.west.cox.net>
References: <Pine.LNX.4.60.0410080704170.6219@dell.enoriver.com>
	<20041008164047.GC14773@smtp.west.cox.net>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <944792EE-194E-11D9-9299-003065F9B7DC@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Fri, 8 Oct 2004 13:22:06 -0400
To: Tom Rini <trini@kernel.crashing.org>
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: cleaning up the Kconfig menu structure -- the bigger picture
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Oct 8, 2004, at 12:40 PM, Tom Rini wrote:

> Which is where every other serial driver is (that's been updated to use
> the new serial core and make life easier).

How does this make life easier?

> That's kinda the opposite direction of where I want things to move.

That doesn't make sense to those of us with experience using all
of the 8xx/82xx/85xx variants, other processors that may use the
same peripherals (like ColdFire), or with knowledge of yet to be
announce parts.

> What, IMHO, should happen is that once the real drivers side of 8xx_io
> are moved out into drivers/ we'll really be left with commproc and
> microcode, both of which can live in arch/ppc/syslib/ as cpm1_common.c

That's irrelevant to keeping the menu options in a central place.
Maybe it's because I'm old, but keeping the CPM configuration options
in one place on the screen seems to make it easier to think and choose
the proper options.  Remember, there is lots more to the CPM than just
serial ports or Ethernet drivers.  There are drivers floating around 
that
for some mysterious reason never seem to make it into the Linus tree
or out of development trees into other "official" place.

> ....... and we can deal with microcode
> questions in arch/ppc/Kconfig where we now source the 8xx_io/Kconfig
> file ....

There is never any harm in separating logical functions into separate
files.  Using this argument I guess you would like the whole kernel
to just be one big Linux.c file? :-)

>  (or, if it really does end up making sense to, and I'm not yet
> convinced of this, make platforms/8xx, we can put the question in
> platforms/8xx/Kconfig).

I don't know why we don't have the platforms/8xx directory.  We already
have 4xx and 85xx, there are certainly more 8xx boards and 
configurations
than anything else (if all of the 2.4 stuff was actually moved 
forward).  Both
of the 4xx and 85xx have special IO configuration options even though
they have drivers in the standard places.  Your desire of "where you 
want
8xx to move" is against what has been established for other processors,
and of course doesn't make sense to me.

Thanks.

	-- Dan
