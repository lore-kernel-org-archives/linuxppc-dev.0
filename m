Date: Fri, 16 Nov 2001 19:16:41 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Matt Porter <mporter@mvista.com>,
	t@cpe-24-221-152-185.az.sprintbbd.net,
	linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: Organisation of 4xx initialization code
Message-ID: <20011116191641.B9923@cpe-24-221-152-185.az.sprintbbd.net>
References: <20011116164625.K673@zax> <20011116045737.A24130@cx258813-a.chnd1.az.home.com> <20011116085121.D5410@cpe-24-221-152-185.az.sprintbbd.net> <20011116094210.B3473@beef.az.mvista.com> <20011117115044.I12763@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011117115044.I12763@zax>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sat, Nov 17, 2001 at 11:50:44AM +1100, David Gibson wrote:
> On Fri, Nov 16, 2001 at 09:42:10AM -0700, Matt Porter wrote:
> > Leave the 440 out of this, it should never pollute the classic PPC
> > tree if it's done correctly.
>
> Yes and no.  That's probably true for the processor core, but it's
> likely to have onboard peripherals which are the same as or very
> similar to older 4xx designs.  It would be nice if we could share the
> code for handling these devices.

Right.  Which is why we need to seperate out peripherals from core so
that it will just work on any new 4xx processor, provided things didn't
get dramatically changed around.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
