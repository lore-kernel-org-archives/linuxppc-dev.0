Date: Wed, 27 Feb 2002 12:46:44 +0100 (CET)
From: Christian Pellegrin <chri@infis.univ.trieste.it>
To: Geir Frode Raanes <geirfrs@invalid.ed.ntnu.no>
Cc: Jerry Van Baren <vanbaren_gerald@si.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: custom mpc8240 student project (long)
In-Reply-To: <20020225115719.P58832-100000@invalid.ed.ntnu.no>
Message-ID: <Pine.LNX.4.44.0202271237380.8890-100000@sole.infis.univ.trieste.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 25 Feb 2002, Geir Frode Raanes wrote:

>
>
> > The software, which is the part covered by the NDA, you can download
> > from Macraigor for _FREE_ so quicherbitchin:
>
> The first shot is, as we know, always free.
>

not true. I had to use JTAG on arm7tdmi project and the tool from
Macraigor it's not free. I mean the module and the .so that drives the
raven are propietary (object only, no warranty) software. I didn't managed
to make it working for parport problems, kernel symbols incompatibility
and such. I gave up, build a parport-jtag adaptor myself and wrote an
(open-source 100%) jtag downloader and basic debugger. Someday I hope to
have enough time to integrate it with gdb.

>
> I do not disagree. It is just that I am cut of from JTAG.
> Which means I've got to stay at 8xx series with BDM. This pisses me off.

I agree 100% with you.

>
> But of cause, if noone wants such an EPROM emulator then there
> is no point in me designing and testing one, is there?
>

Be aware that I read on an italian electronic magazine that eprom
emulation is patented ..... patents madness :-((((

Bye!


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
