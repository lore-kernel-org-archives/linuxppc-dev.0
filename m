Date: Fri, 17 Nov 2000 07:52:27 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: frowand@mvista.com
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: header file location
In-Reply-To: <3A146835.DBE53660@mvista.com>
Message-ID: <Pine.LNX.4.05.10011170751110.20673-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 16 Nov 2000, Frank Rowand wrote:
> Is there any documentation of how to decide where to put header files.  I especially
> am trying to understand the distinction between include/asm-ppc/ and arch/ppc/kernel/

If the includes are used in arch/ppc/kernel/ only, put them there. If they are
needed elsewehere as well (arch/ppc/mm/, drivers/..., userspace), put them in
include/asm-ppc/.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
