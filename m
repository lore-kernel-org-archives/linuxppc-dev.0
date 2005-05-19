Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0F60F679F1
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 May 2005 04:03:56 +1000 (EST)
In-Reply-To: <1116517058.24754.10.camel@gleep>
References: <428C352E.1050002@bitsim.se> <1116517058.24754.10.camel@gleep>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <bf240432651c66377c282f68d3ffaae8@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Thu, 19 May 2005 14:04:05 -0400
To: Jon Loeliger <jdl@freescale.com>
Cc: Jakob Viketoft <jakob.viketoft@bitsim.se>,
	Linux PPC Embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: OF flat device tree for ppc32...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On May 19, 2005, at 11:37 AM, Jon Loeliger wrote:

> So, there were two positive comments that I received
> as feedback on my initial suggestion, and no negative
> comments.  (Minor patch deltas not withstanding.)

I have the same negative comments as Wolfgang.
This boot rom to kernel interface is continually discussed,
has been for years, and it just gets a little tiring :-)

The main reason for the original work done to create
the "boot wrapper" functions was to accommodate as
many boot roms as possible, distilled into a minimal
amount of common information.

We still have people (more and more, actually) that want
to run Linux and associated applications in minimal
flash and ram space.  Solutions that require more and
more code get to the point where they simply don't
fit into these systems.

There are also many embedded systems that don't
run something like U-Boot, and even if they did they
are not likely to perform field upgrades just to use
something that adds no value to their product.  We
must be able to accommodate these systems, as
the existing code does today.

Real embedded devices have minimalist requirements.
Minimal flash, minimal ram, minimal boot up time.  Even
today, Linux is too big and too slow for many of these
devices, making other alternatives more attractive.  If
we want to continue with success in this embedded
space, we have to address minimal requirement and
stop changing things to make them look like workstations.
We get spoiled by the few evaluation or demo boards we
see, because they are likely on the resource rich side.
Fine for development, but not something that will
see production.

We have embedded design wins today because of
the code we had years ago.  I'm afraid if we continue
with the code bloat and the performance challenges
we see with 2.6, we are going to lose many of the
new embedded products in the future.

If you consider yourself to be an embedded engineer,
you have to place "minimal resource use" at the top
of your list.  They have to boot and be useful "instantly."

Thanks.


	-- Dan
