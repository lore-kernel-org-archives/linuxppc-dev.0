From: Brad Boyer <flar@pants.nu>
Message-Id: <200002061155.GAA06862@marcus.pants.nu>
Subject: Re: [patch] little-endian dmasound silently fails
To: bh40@calva.net (BenH)
Date: Sun, 6 Feb 2000 03:55:42 -0800 (PST)
Cc: toe@unlserve.unl.edu (Takashi Oe), linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20000205142613.026592@192.168.1.10> from "BenH" at Feb 05, 2000 02:26:13 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


BenH wrote:
> Actually, I had some reports about this problem too and I'm wondering if
> all revisions of AWACS actually support byte swapping. (I think I
> remember seeing a comment on this list telling explicitely that some
> revisions didn't support it).

Well, I know I complained several times, but I found out recently when I
did some more careful testing that I was wrong.  I have a rev 2 AWACS chip
in my computer, and the byteswap does work.  My problem was that I had a
number of programs which set the format improperly, and I didn't notice
the problem when I looked at the code.  As an example, snes9x explicitly
asks for a little-endian format, then generates the sound in native
order.  Unless you can find someone with a rev 1 AWACS chip and test
that one, I imagine you can assume that all of them support byteswap
properly.  And since the 7600 I have is one of the oldest machines that
is supported, I imagine you won't find anyone with rev 1 unless they
changed in between the 7500 and 7600.  I would guess that rev 1 was
used in the nubus powermacs.

	Brad Boyer
	flar@pants.nu


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
