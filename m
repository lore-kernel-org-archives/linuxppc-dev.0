Date: Sat, 9 Feb 2002 10:10:29 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Val Henson <val@nmt.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] Make Gemini boot
Message-ID: <20020209171029.GL20094@opus.bloom.county>
References: <20020208185019.G28166@boardwalk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020208185019.G28166@boardwalk>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Feb 08, 2002 at 06:50:19PM -0700, Val Henson wrote:

> This patch consists of all the bits that didn't really impact
> non-Gemini machines.  If you apply all of it, Gemini will boot in the
> linuxppc_2_4_devel tree.

Erm, can you fix the current code to work on all of the various gemini
boards?  I really don't want to bring back the piggyback bits (which are
only slightly better than the size/offset hacks).  There's nothing wrong
w/ adding #ifdef CONFIG_GEMINI in a place or two.  In fact, the
'setup_legacy()' call in misc-simple.c is for exactly the same problem
the gemini_console_baud_fixup(port) call is for (and since the others
are in asm, just change the prototype to take an arg, which they will
ignore).

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
