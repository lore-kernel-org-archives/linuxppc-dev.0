Date: Sun, 17 Mar 02 12:10:43 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0203172010.AA01807@ivan.Harhan.ORG>
To: linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] My GT-64260 enhancements
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek <dan@embeddededge.com> wrote:

> So, I don't see the problem.  A default is specified and you can change it,
> just like lots of other configurations.

The problem is that there is a

define_int CONFIG_SERIAL_CONSOLE_BAUD 115200

line in arch/ppc/config.in for "$CONFIG_EV64260" = "y" but not for any other
almost-non-embedded-standard-computer 6xx/7xx/74xx board, which is
discriminatory and undemocratic.

Having "$CONFIG_GT64260" = "y" imply support for CONFIG_SERIAL_TEXT_DEBUG is
also discriminatory and undemocratic. Should we also imply the same then for
"$CONFIG_CPC700" = "y" -o "$CONFIG_CPC710" = "y" -o "$CONFIG_UNINORTH" = "y",
etc?

I mean I don't mind if defaults are changed globally, it's just the
discriminatory treatment of GT-64260 that I violently object to. Oh, and having
a separate BK tree and mailing list for it too isn't something I'm fond of.

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
