Message-ID: <396B19BF.D2EAF0D7@agelectronics.co.uk>
Date: Tue, 11 Jul 2000 13:57:35 +0100
From: Adrian Cox <apc@agelectronics.co.uk>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Going from 2.2.12 to 2.2.17pre10
References: <396AEAC7.D8CACCB2@agelectronics.co.uk> <20000711101714.9717@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:

> In the case of Apple HW, the OF device tree is the only way to know about:
> [big list of things Apple OF tells you]

Actually, I'm whining about nothing. I just did a search of the drivers
tree, and the only generic PCI device that uses the OF tree is
chipsfb.c. Of course, that's the one I've been porting to a more generic
PCI device driver aimed at the later C&T devices.

As Geert has declared intent to move the FB drivers to PCI probing, this
is a non-issue.

- Adrian

btw: Off topic: which Powerbook uses chipsfb? If they're cheap
secondhand I'll consider becoming my own guinea-pig for the merged
driver.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
