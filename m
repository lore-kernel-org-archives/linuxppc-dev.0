Message-ID: <3A65E975.C1D4D917@mvista.com>
Date: Wed, 17 Jan 2001 13:50:29 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Jay Monkman <jmonkman@adventnetworks.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8260 Development tools
References: <CD5CA14300A9D54A8D13D58CD3C87B420BF014@advcorp-exc01.advent.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jay Monkman wrote:

> Is there a better eval board than EST's SBC8260?

Check out Cogent Computer systems (www.cogcomp.com).

> I may end up with an EST VisionICE II debugger. Has anyone used it
>         with GDB? Or use the software that comes with it for debugging?

You won't  be happy with it for Linux.

>         Would Abatron's BDI-2000 be better?

Absolutely.  It is Linux-aware and works very well.

> Is 2MB FLASH and 8 MB RAM still the recommended minimum?

Probably.  If you can find that little memory any more.  Most
82xx have at least 16 MB RAM, typical is 64 MB.

> Are there any gotcha's I should watch out for?

Lots, I suppose, depending upon your experience with either
8260 or Linux.

	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
