Subject: Re: 2.4 versus 2.6 patches
From: David Woodhouse <dwmw2@infradead.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <Pine.LNX.4.60.0407231055450.5463@localhost.localdomain>
References: <Pine.LNX.4.60.0407231055450.5463@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 24 Jul 2004 11:20:08 -0400
Message-Id: <1090682408.4195.3.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 2004-07-23 at 10:57 -0400, Robert P. J. Day wrote:
> for most of the folks on this list, i suspect they'd be more
> interested in patches to a 2.6-style Kconfig file, not a 2.4-style
> config.in file, correct?

Yes. The 2.4 kernel is dead.

There are two classes of people -- those who are shipping 2.4 already or
at least close to doing so, and those who are bringing Linux up on a new
board.

The former are hopefully already past the stage of being confused by
such things in the config files, and the latter should most definitely
be using 2.6.

--
dwmw2


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
