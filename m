From: Benjamin Herrenschmidt <bh40@calva.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux/PPC Development
 <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
Date: Fri, 22 Sep 2000 00:41:07 +0200
Message-Id: <19340816161251.5999@192.168.1.10>
In-Reply-To: <Pine.LNX.4.10.10009211536590.375-100000@cassiopeia.home>
References: <Pine.LNX.4.10.10009211536590.375-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>And we still didn't mention the nightmare called ISA memory space... Where is
>your legacy VGA memory?

I think we simply don't have access to it. Maybe on Grackle machines, we
could try to hack the bridge config (MPC106), but I don't know if Apple's
bandit can generate PCI mem cycles at 0.

Well, weren't some of the early Apple PPC servers running AIX based on
Bandit and using legacy VGA text mode ?
In this case, it may be possible to configure Bandit to open a window to
the ISA memory space...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
