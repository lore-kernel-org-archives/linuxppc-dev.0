Date: Thu, 11 Apr 2002 08:29:26 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Incoming to helium.harhan.org:/home/linuxppc/linuxppc_2_4_alt
Message-ID: <20020411152926.GD15663@opus.bloom.county>
References: <20020410150936.GB26754@opus.bloom.county> <0204110311.AA27153@ivan.Harhan.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0204110311.AA27153@ivan.Harhan.ORG>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Apr 10, 2002 at 08:11:56PM -0700, Michael Sokolov wrote:
>
> Tom Rini <trini@kernel.crashing.org> wrote:
>
> > So why not ask it for boards where it's reasonable?
>
> So you mean replace the "$CONFIG_GENERIC_PPC32" = "y" condition with
> "$CONFIG_BOARD_X" = "y" -o "$CONFIG_BOARD_Y" = "y" etc? Fine with me, but I
> thought that was ugly code by your standards... :-)

Config files are where you're supposed to figure things out, not the C
files :)

Maybe someday we'll have some automagic bits in the config language
where we can specific sections and create all of the config questions on
the fly or something, but for now...

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
