Date: Sat, 3 Nov 2001 08:15:53 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: boot methods
Message-ID: <20011103081553.C29932@cpe-24-221-152-185.az.sprintbbd.net>
References: <20011102185547.B29932@cpe-24-221-152-185.az.sprintbbd.net> <20011103094543.10BDA10CDB@denx.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011103094543.10BDA10CDB@denx.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Nov 03, 2001 at 10:45:37AM +0100, Wolfgang Denk wrote:
> In message <20011102185547.B29932@cpe-24-221-152-185.az.sprintbbd.net> you wrote:
> >
> > Vendor                Extension               How
> > IBM Spruce            .spruce                 ???
> > Force PowerCore       .pcore                  PowerBoot (Force firmware)
> > Force PowerPMC 250    .pcore                  PowerBoot
> > M.E.N. F1             .menf1                  ??? (Probably custom fw).
> > Motorola LoPEC        .pplus/.bugboot[1]      PPCBUG
> > Motorola MCPN765      same                    same
> > Motorola MVME5100     same                    same
> > Motorola PrPMC750     same                    same
> > Motorola PrPMC750     same                    same
> > Motorola Sandpoint    .sandpoint              DINK32
[snip]

[1]: .bugboot is for images in flash.

> > Why is the how important?  With the exception of firmware-deficiencies,
> > the current wrapper doesn't really care what it came from.  And they
>
> ...or there is no wrapper at all.

But that's going to be much of an option.  I think we want to enforce
some wrapper, so that things like PPCBoot aren't effected by internal
changes.  And I don't think the PPCBoot wrapper needs to be all that big
either.  I do need to sit down and verify this, but a PPCBoot wrapper
could be as minimal as taking a current bd_t structure and converting it
to bi_recs.  No duplicated serial, et al.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
