Date: Wed, 24 Oct 2001 15:48:49 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "David M?ller (ELSOFT AG)" <d.mueller@elsoft.ch>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] Various patches against linuxppc_dev-2.4.13-pre6
Message-ID: <20011024154849.A27625@cpe-24-221-152-185.az.sprintbbd.net>
References: <3BD50D4E.6060401@elsoft.ch> <20011023073258.B30012@cpe-24-221-152-185.az.sprintbbd.net> <3BD6AB69.5010704@elsoft.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3BD6AB69.5010704@elsoft.ch>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Oct 24, 2001 at 01:52:09PM +0200, David M?ller (ELSOFT AG) wrote:
> Tom Rini wrote:
>
> >On Tue, Oct 23, 2001 at 08:25:18AM +0200, David M?ller (ELSOFT AG) wrote:
[snip]
> >> - arch/ppc/kernel/i8259.c
> >>    consistent nameing (rather cosmetic change)
> >
> >Not sure about.  Why either of those changes?
>
>
> The first patch is just a prettyprint fix. At least on my system
> it looks better this way ;-)
>
> Everywhere in the i8259.[ch] files the chip is called "i8259" with the
> exception of one place which is fixed by the second patch. But as
> i said, it's more of a cosmetic change.

Okay, I wasn't totally sure about it and didn't have time to dig into
it.  I'll throw those in sometime soonish.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
