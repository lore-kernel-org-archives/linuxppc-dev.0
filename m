Message-ID: <3D4847D5.9030404@embeddededge.com>
Date: Wed, 31 Jul 2002 16:25:57 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [RFC/PATCH] idle loop changes
References: <20020731193200.GD17472@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini wrote:

> I'm not totally sure if it's better to do it this way, or to not provide
> a default power_save(), so that if we don't set pm_idle to something, we
> just never call power_save() (as opposed to a call, check for a bit &
> return).  Comments?

I think whether we force everything to have a power_save() function,
even if it is empty, or initialize a pointer and have an indirect call
doesn't make much difference.  What does make a difference, is there could
be power save functions that are unique to a board.  Some processors have
power save options that can cause a lower frequency clock to be used which
will affect external devices.  In such cases, the devices on a board may
need some adjustment when these power save modes are entered/exited.

Thanks.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
