Content-Type: text/plain;
  charset="iso-8859-1"
From: Ricardo Scop <scop@digitel.com.br>
To: Dan Malek <dan@mvista.com>
Subject: Re: BK to CVS? + MDIO
Date: Fri, 5 Oct 2001 23:52:47 +0300
Cc: Andrew Johnson <anj@aps.anl.gov>,
	linuxppc-embedded@lists.linuxppc.org,
	Tom Rini <trini@kernel.crashing.org>
References: <20011003130559.F31866@borg.org> <01100519044401.01029@scop.digitel.com.br> <3BBE6B92.60497E1@mvista.com>
In-Reply-To: <3BBE6B92.60497E1@mvista.com>
MIME-Version: 1.0
Message-Id: <01100523524704.16297@scop.digitel.com.br>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, Dan

I can assure you that I intend to follow strictly your orders :^) when
submitting a patch to the linuxppc development tree.

However, I didn't tell the whole truth. Actually, I'm currently not using BK,
but instead rsyncing from the source.mvista.com mirror. Is that all right for
obtaining the current sources?

[  Thanks, Tom, I've just received your reply, I'll save your instructions
to use when and if my company allow us to use BK ]

BTW, I'm staring right now at the FCC driver for the MPC8260, looking for
MDIO support, and I can see that it's not compiled by default. Can you tell
me if it's operational? Our board has a Level One LTX960A PHY Transceiver
which is only working at 10 Mbps, and I would like to force it to 100 Mbps at
user's will.
('hope I'm not pushing you guys too much which parallel questions in a
reply...)

On Saturday 06 October 2001 05:25, Dan Malek wrote:
> Ricardo Scop wrote:
> > We internally use CVS nowadays, therefore I'm very interested in your
> > standard procedures to manage externally developed code.
>
> I would appreciate a patch against the current linuxppc_2_4_devel
> tree.  Please pull the latest tree, do your work in that tree, and
> then generate a patch using one of the convenient bk commands that
> I hope Tom Rini can suggest :-).
>
> It's quite time consuming to get patches that are "almost" up to
> date and having to manually sort out the differences.  I could spend
> 24 hours a day just applying and testing patches sent to my personal
> e-mail addresses.  It _really_ helps when they are up to date :-).
>
> Thanks.
>
>
> 	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
