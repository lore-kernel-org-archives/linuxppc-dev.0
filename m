Message-ID: <39B37B7C.71D37D8C@agelectronics.co.uk>
Date: Mon, 04 Sep 2000 11:37:48 +0100
From: Adrian Cox <apc@agelectronics.co.uk>
MIME-Version: 1.0
To: Bob Doyle <doyle@primenet.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux on Motorola Sandpoint/PPMC7400
References: <20000828225504.B23679@hectic.net> <39AAF258.B43B901@mvista.com> <20000829201347.A30190@hectic.net> <39AC2AB9.D47ADE73@mvista.com> <20000828225504.B23679@hectic.net> <39AAF258.B43B901@mvista.com> <20000829201347.A30190@hectic.net> <39AC0BF9.38DB6A9A@mvista.com> <20000830215856.B5340@hectic.net> <39B1D6CF.351969B4@primenet.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Bob Doyle wrote:

> If someone was interested in making a more useful bootloader
> for linux/sandpoint I'd look into cleaning it up (removing
> the proprietary stuff) and releasing the code.

I've got code that boots a kernel image over ethernet, but I've been
experimenting mostly on a different platform to the Sandpoint. I'm
planning a release around October, when I should have the time. The
architecture of mine is quite modular, so it should be easy to insert
things like the floppy and vga drivers, using my code as glue.

- Adrian Cox

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
