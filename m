To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: David Edelsohn <dje@watson.ibm.com>,
	Kaoru Fukui <k_fukui@highway.ne.jp>, Jean-Jacques.Levy@inria.fr,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: __divdi3 unresolved + X pointer blocks
References: <Pine.LNX.4.05.10107051012150.10817-100000@callisto.of.borg>
From: Holger Bettag <hobold@Informatik.Uni-Bremen.DE>
Date: 05 Jul 2001 13:48:41 +0200
In-Reply-To: Geert Uytterhoeven's message of Thu, 5 Jul 2001 10:13:16 +0200 (CEST)
Message-ID: <8xr8vv61gm.fsf@s62.informatik.uni-bremen.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven <geert@linux-m68k.org> writes:

>
>
> On Wed, 4 Jul 2001, David Edelsohn wrote:
> > 	You do not seem to have understood my reply.  I will repeat the
> > important sentence:
> >
> > 	SHIFT IS NOT THE SAME AS DIVIDE FOR SIGNED INTEGERS.
>
> Indeed. That's why you have `logical shift right' and
> `arithmetic shift right'.
> The former inserts zeroes, the latter inserts a copy of the MSB.
>
> Don't know from memory whether PPC has them...
>
Yes, PowerPC has both; but some forms don't have their own opcodes, as they
are emulated with bitfield instructions.

And: 'arithmetic shift right' is _not_ the same as signed divide, because the
rounding of negative operands or results may differ.

  Holger


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
