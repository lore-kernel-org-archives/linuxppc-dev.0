Return-Path: <bouncefilter+linuxppc-embedded=wd=denx.de@lists.linuxppc.org>
Message-Id: <4.3.2.20011008074637.00c64340@falcon.si.com>
Date: Mon, 08 Oct 2001 08:01:28 -0400
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: BK to CVS? + MDIO
In-Reply-To: <01100523524704.16297@scop.digitel.com.br>
References: <3BBE6B92.60497E1@mvista.com>
 <20011003130559.F31866@borg.org>
 <01100519044401.01029@scop.digitel.com.br>
 <3BBE6B92.60497E1@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Ricardo:

For PPCBoot, I made MII serial interface routines for the EST
(WindRiver) SBC8260 board.  This was a general purpose implementation,
customizable for different hardware by changing the #defines that
toggled the I/O port pins.  I also added a "mii" command that allows
you to read and write the MII registers from the command line.  I was
able to read and write the EnableSemi (Lucent) PHY, which is a "dongle"
type PHY provided by EST.  This could be helpful for you for poking
around in the PHY.  If your needs are not too complex, it may be
sufficient to initialize the PHY and let it run autonomously.

I submitted patches to Wolfgang, but it appears they have not been
rolled into the source yet.  If you want a patch, reply to my email
address and I'll send you one.

gvb


At 11:52 PM 10/5/01 +0300, Ricardo Scop wrote:

>Hi, Dan
>
>I can assure you that I intend to follow strictly your orders :^) when
>submitting a patch to the linuxppc development tree.
>
>However, I didn't tell the whole truth. Actually, I'm currently not
>using BK,
>but instead rsyncing from the source.mvista.com mirror. Is that all
>right for
>obtaining the current sources?
>
>[  Thanks, Tom, I've just received your reply, I'll save your instructions
>to use when and if my company allow us to use BK ]
>
>BTW, I'm staring right now at the FCC driver for the MPC8260, looking for
>MDIO support, and I can see that it's not compiled by default. Can you
>tell
>me if it's operational? Our board has a Level One LTX960A PHY Transceiver
>which is only working at 10 Mbps, and I would like to force it to 100
>Mbps at
>user's will.
>('hope I'm not pushing you guys too much which parallel questions in a
>reply...)
>
>On Saturday 06 October 2001 05:25, Dan Malek wrote:
> > Ricardo Scop wrote:
> > > We internally use CVS nowadays, therefore I'm very interested in your
> > > standard procedures to manage externally developed code.
> >
> > I would appreciate a patch against the current linuxppc_2_4_devel
> > tree.  Please pull the latest tree, do your work in that tree, and
> > then generate a patch using one of the convenient bk commands that
> > I hope Tom Rini can suggest :-).
> >
> > It's quite time consuming to get patches that are "almost" up to
> > date and having to manually sort out the differences.  I could spend
> > 24 hours a day just applying and testing patches sent to my personal
> > e-mail addresses.  It _really_ helps when they are up to date :-).
> >
> > Thanks.
> >
> >
> >       -- Dan
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
