Date: Thu, 12 Feb 2004 07:07:56 +0100
From: Costantino Pistagna <cpistagna@vrlteam.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: ibook G4 Status Report
Message-ID: <20040212060756.GG2200@adapter.n0skillz.org>
Reply-To: cpistagna@vrlteam.org
References: <27203D60-5B28-11D8-A96D-000A95B30208@vrlteam.org> <1076361029.763.13.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1076361029.763.13.camel@gaston>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Feb 10, 2004 at 08:10:30AM +1100, Benjamin Herrenschmidt wrote:

> You have a VGA or DVI output ? VGA I think ? It should work with
> Michel Danzer packages but it will be an analog output, not as good
> as a fully digital.

yep, you're right! I was unhappy in my previous message. I've an analog VGA
monitor connected to my ibook. All i want to do is use my external CRT monitor
with X or consoleFB. I've googled for "Michel Danzer", but without any success at all.
any clues ?

> XFree doesn't drive properly a DVI output on a laptop yet, though
> I got it to work with a small userland hack I use to "fix" the chip
> after X configured it ;)

no matter for DVI output, yet. thanks at all.

> Note that you may also have a problem with XFree not setting the proper
> divider for your internal panel when used without UseFBDev. Same issue,
> I have a userland "fix" for that since fixing it in XFree itself isn't
> quite simple at this point.

I've noticed this problem. the only way to get XFree working properly, is
to use the UseFBDev directive into XF86Config. Unfortunately, this directive
seems to get in troubles with dualhead XF86Config (i've used the one that i'm
using in my desktop, equipped with a Rage128): the panels are waiting for
something with a black screen. If it's usefull, i'm using an XFree 4.3.0 binary
merged with gentoo/ppc.

cheers,
--
[ Costantino Pistagna (PhD) :: unict :: dmi ]
[ gpg key on pgp.mit.edu :: keyid  1d67b4dd ]

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
