Date: Fri, 27 Jul 2001 11:07:59 -0700 (PDT)
From: Paul White <pwhite@networkrobots.com>
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Quick Question on ioremap_base
Message-ID: <Pine.LNX.4.21.0107271105110.4817-100000@stimpy.networkrobots.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


All,

I have a quick question regarding setting the
ioremap_base and ioremap_bot in arch/ppc/mm/init.c

How do you determine this value?  I am setting it
to an invalid value, because my vmalloc()'s are
failing after the first one when booting up.

>From the code, I see that:

Default is set to 0xf8000000, and then,
the following platforms do this:

Prep:    0xf0000000
Chrp:    default
Pmac:    0xfe000000
apus:    default
gemini:  default
8260:    0xe0000000

Can someone explain how to "decide" this value?

Paul W.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
