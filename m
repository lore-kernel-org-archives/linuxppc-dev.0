Date: Fri, 5 Oct 2001 20:34:19 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Ricardo Scop <scop@digitel.com.br>
Cc: Dan Malek <dan@mvista.com>, Andrew Johnson <anj@aps.anl.gov>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: BK to CVS? + MDIO
Message-ID: <20011005203419.A10494@cpe-24-221-152-185.az.sprintbbd.net>
References: <20011003130559.F31866@borg.org> <01100519044401.01029@scop.digitel.com.br> <3BBE6B92.60497E1@mvista.com> <01100523524704.16297@scop.digitel.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <01100523524704.16297@scop.digitel.com.br>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Oct 05, 2001 at 11:52:47PM +0300, Ricardo Scop wrote:

> However, I didn't tell the whole truth. Actually, I'm currently not using BK,
> but instead rsyncing from the source.mvista.com mirror. Is that all right for
> obtaining the current sources?

Yes.  The rsync is usually only a few minutes behind the bk mirror
(which is a few minutes behind the master bk tree).

> BTW, I'm staring right now at the FCC driver for the MPC8260, looking for
> MDIO support, and I can see that it's not compiled by default. Can you tell
> me if it's operational? Our board has a Level One LTX960A PHY Transceiver
> which is only working at 10 Mbps, and I would like to force it to 100 Mbps at
> user's will.

If you turn on CONFIG_USE_MDIO, it _may_ work.  You might have to add in
support for the LTX960A tho (only 970 and 971 are explicitly supported).

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
