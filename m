Message-ID: <3BE087DA.8F9ED9CC@linux-m68k.org>
Date: Thu, 01 Nov 2001 00:23:06 +0100
From: Roman Zippel <zippel@linux-m68k.org>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: small cleanup
References: <20011031084233.A18493@cpe-24-221-152-185.az.sprintbbd.net> <Pine.LNX.4.33.0110312042050.1723-100000@serv> <20011031155335.A20613@cpe-24-221-152-185.az.sprintbbd.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Tom Rini wrote:

> I will when I get a moment.. :)  But #ifndef __FOO__ #define __FOO__
> #ifdef __BAR__ ... #endif /* __BAR__ */ #endif /* __FOO__ */ works
> better than checking for __BAR__ first?

IMO yes: "If a subsequent `#include' specifies the same file, and the
macro in the `#ifndef' is already defined, then the file is entirely
skipped, without even reading it."

bye, Roman

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
