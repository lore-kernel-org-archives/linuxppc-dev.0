Date: Fri, 16 Feb 2001 14:48:24 -0600
From: "Joseph P. Garcia" <jpgarcia@execpc.com>
To: "Iain Sandoe" <iain@sandoe.co.uk>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: some kernel patches I have (vs. kinda recent BK-2.4)
Message-Id: <20010216144824.56893ff3.jpgarcia@execpc.com>
In-Reply-To: <20010216203816.B7011DB9F3@atlas.valhalla.net>
References: <20010216203816.B7011DB9F3@atlas.valhalla.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


That's the one.  The numerical ones were 2.2.x.  Very nice patch.  verbose /dev/sndstat, pass thru works wonderfully, and doesn't lock up as a module on my wallstreet.  Excellent work.

On Fri, 16 Feb 2001 20:38:56 +0000, "Iain Sandoe" <iain@sandoe.co.uk> wrote:
>
> > Iain Sandoe's dmasound patch, #21 IIRC.
>
> as of now you need to use:
>
> ftp://ftp.penguinppc.org/users/iain/kernel/2_4_x/2.4.2p1-dmasound-patches/dm
> asnd-2.4.2p1_all.diff.bz2
>
> (it was OK against -pre3 pull last night).
>
> ed21 will not work against BK - because Paulus has merged part of my changes
> and his in already.
>
> there are some bits (that were in ed21) missing (sorry) I'm still working on
> merging them with the latest stuff.
>
> ciao,
> Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
