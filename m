Date: Wed, 28 Nov 2001 16:43:06 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_ALL_PPC
Message-ID: <20011128164306.D29541@cpe-24-221-152-185.az.sprintbbd.net>
References: <15365.24592.409195.392505@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15365.24592.409195.392505@gargle.gargle.HOWL>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Nov 29, 2001 at 09:07:12AM +1100, Paul Mackerras wrote:
>
> I want to rename CONFIG_ALL_PPC to CONFIG_PREP_PMAC_CHRP in the
> linuxppc_2_4_devel tree (or if anyone can suggest a better name I'll
> use that).
>
> Does anyone object to this?

Yes.  For historical note, the old 2_5 tree had CONFIG_WORKSTATION_PPC,
which suited most people.  But there's the fact that most of the
7xx/74xx boards in _devel now can take a video card and be a
'workstation' too. :)

How about we don't do this in 2_4 (or 2_4_devel) at all since it'll be a
bit of a maintance headache (2.4.x, x <= A is CONFIG_ALL_PPC, > A might
be XXX or ALL_PPC, and >= B it got into kernel.org, ick..).

Perhaps we could even go as far as doing CONFIG_OPENFIRMWARE_PPC for
chrp/pmac/pop, bring back CONFIG_PREP for 'PReP', and work on doing
plaform support along the lines of Y/N instead of group A, B, or C.

Or barring all of that messy work, CONFIG_COMMON_PPC :)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
