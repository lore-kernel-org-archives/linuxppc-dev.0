From: benh@kernel.crashing.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Linux/PPC BK repository <linuxppc@helium.Harhan.ORG>,
	<linuxppc-commit@source.mvista.com>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Incoming to helium.harhan.org:/home/linuxppc/linuxppc_2_4_alt
Date: Tue, 9 Apr 2002 12:08:30 +0200
Message-Id: <20340715221138.20391@mailhost.mipsys.com>
In-Reply-To: <Pine.GSO.4.21.0204091013120.13709-100000@lisianthus.sonytel.be>
References: <Pine.GSO.4.21.0204091013120.13709-100000@lisianthus.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>> Yes, though it will be separated from the actual code, and I'm
>> thinking about eventually auto-generating it.
>
>Or put the pointers to the ppc_md structs in a new section, cfr. the
>module_init() stuff.
>

Right. That's the best solution for now. Though I may still do some
local code munging as I want to see how feasible it is to have _machine
be #defined instead of beeing a variable when only one board is selected
in the config, and without having to write a #ifdef mess in a .h for each
new board added.

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
