Date: Fri, 16 Nov 2001 19:18:29 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Matt Porter <mporter@mvista.com>,
	linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: Organisation of 4xx initialization code
Message-ID: <20011116191829.C9923@cpe-24-221-152-185.az.sprintbbd.net>
References: <20011116164625.K673@zax> <20011116045737.A24130@cx258813-a.chnd1.az.home.com> <20011116085121.D5410@cpe-24-221-152-185.az.sprintbbd.net> <20011117113541.E12763@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011117113541.E12763@zax>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sat, Nov 17, 2001 at 11:35:41AM +1100, David Gibson wrote:
> On Fri, Nov 16, 2001 at 08:51:21AM -0700, Tom Rini wrote:
> > But that's just it.  Someone else should probably speak up on this, but
> > in the 403/405/stb0{3,4}xxx, and possibly 440 when it exists there are
> > some things which always exist, depending on processor.  Each 750 board
> > for example can really have almost anything attached to it.  But for a
> > 405GP, there are known things and some variable things.  I _think_ 4xx
> > boards vary more like the 8xx ones do, than 750 does.
>
> Yes, but how the current code tends to make assumptions about how the
> onboard devices have been configured by the firmware, and that does
> vary from board to board.

Yes, and these assumptions are bugs which need fixing.

'Common' stuff needs to be seperated out more from 'core' stuff.  Feel
free to post patches for this stuff.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
