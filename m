Message-ID: <3C968679.7040307@embeddededge.com>
Date: Mon, 18 Mar 2002 19:29:45 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Ethan Benson <erbenson@alaska.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: new bi_rec interface (was Re: [Ppcboot-users] Re: EV-64260 booting)
References: <20020312195125.GB25926@cpe-24-221-152-185.az.sprintbbd.net> <21274.1015997038@msa.cmst.csiro.au> <20020313155503.GB721@opus.bloom.county> <20020318152329.B324434@brule.borg.umn.edu> <20020318143326.B26309@plato.local.lan>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ethan Benson wrote:

> from a logistical point of view this really seems to be the best
> approach.

This has been the normal mode of operation for the embedded boards.
Many of us think it is the logical approach, and quite a while ago
some of us started talking about how we can combine these ideas
in an effort to remove a reasonable amount of board specific code
from the kernel setup functions.

There were some challenges while trying to move from one method
to another, with the transition being the 2.4 source tree.  For
2.5 we just "declared" this will be the way.

> of course if someone doesn't want to use the wrapper they can just use
> the vmlinux and write thier own bootloader to handle all this stuff
> and take on the effort of ensuring its up to date with what the kernel
> wants.

There are people that want to do this and see value in doing so.  It
does present a challenge as I was one that broke ppcboot when I changed
the interface between the bootloader and the kernel (thinking everyone
used the bootloader wrapper on embedded boards :-).


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
