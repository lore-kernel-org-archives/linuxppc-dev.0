Subject: Re: loading the kernel and root FS separately from flash?
From: David Woodhouse <dwmw2@infradead.org>
To: Wolfgang Denk <wd@denx.de>
Cc: "Robert P. J. Day" <rpjday@mindspring.com>,
	Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <20040628103630.D1709C109F@atlas.denx.de>
References: <20040628103630.D1709C109F@atlas.denx.de>
Content-Type: text/plain
Message-Id: <1088419257.6992.3.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Mon, 28 Jun 2004 11:40:58 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 2004-06-28 at 12:36 +0200, Wolfgang Denk wrote:
> In message <1088415754.6992.1.camel@hades.cambridge.redhat.com> you wrote:
> >
> > I think it should be OK when it's 4MiB in size. Mount time was far more
> > of a problem in JFFS2 many years ago when people were using the 2.4
> > kernel. It's a lot faster in 2.6.
>
> Is this really a question of which  kernel  is  running?  It  was  my
> impression that this is merely an issue of which version of the JFFS2
> (i. e. MTD) code you are using?

True -- for the moment at least you can drop the JFFS2 development tree
into a 2.4 kernel.

--
dwmw2


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
