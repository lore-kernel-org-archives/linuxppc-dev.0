Date: Thu, 5 Jul 2001 10:13:16 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: David Edelsohn <dje@watson.ibm.com>
Cc: Kaoru Fukui <k_fukui@highway.ne.jp>, Jean-Jacques.Levy@inria.fr,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: __divdi3 unresolved + X pointer blocks 
In-Reply-To: <200107042318.TAA26354@makai.watson.ibm.com>
Message-ID: <Pine.LNX.4.05.10107051012150.10817-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 4 Jul 2001, David Edelsohn wrote:
> 	You do not seem to have understood my reply.  I will repeat the
> important sentence:
>
> 	SHIFT IS NOT THE SAME AS DIVIDE FOR SIGNED INTEGERS.

Indeed. That's why you have `logical shift right' and `arithmetic shift right'.
The former inserts zeroes, the latter inserts a copy of the MSB.

Don't know from memory whether PPC has them...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
