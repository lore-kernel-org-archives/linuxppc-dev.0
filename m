Date: Mon, 31 Mar 2003 15:05:30 +0200
From: Toni Van Remortel <t.vanremortel@ha.be>
To: Kenneth Johansson <kenneth.johansson@etx.ericsson.se>
Cc: ebs@ebshome.net, linuxppc-embedded@lists.linuxppc.org
Subject: Re: EP405 linker error.
Message-Id: <20030331150530.1e2f02b6.t.vanremortel@ha.be>
In-Reply-To: <1049114664.31297.208.camel@spawn>
References: <20030331111051.74af0790.t.vanremortel@ha.be>
	<5.1.0.14.2.20030331011506.02cd4d78@mail.ebshome.net>
	<20030331113552.58ceec69.t.vanremortel@ha.be>
	<1049114664.31297.208.camel@spawn>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 31 Mar 2003 14:44:24 +0200
Kenneth Johansson <kenneth.johansson@etx.ericsson.se> wrote:

>
> On Mon, 2003-03-31 at 11:35, Toni Van Remortel wrote:
> >
> > I didn't know that there was an ATI RADEON on this EP405 ;-) How come that it seeks for that? Wrong .config?
> >
>
> The check is done in runtime not when you compile and you can have the
> card  on any system with a pci bus.
>
> For now just remove the line and everything will be OK since you did not
> have the card.

I commented out line 693 in drivers/pci/quirks.c and now it compiles. Thanks for the info.

--
Toni Van Remortel - Scientific Researcher
D-science lab (Hogeschool Antwerpen)
Phone: +32 (0) 3 205 61 72
Fax  : +32 (0) 3 205 61 95

Current project:
LinEmb: RealTime and Embedded Linux
(http://linemb.d-sciencelab.com)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
