Subject: Re: kernel option "Command line partition table parsing"
From: David Woodhouse <dwmw2@infradead.org>
To: Wolfgang Denk <wd@denx.de>
Cc: Sylvain Munaut <tnt@246tnt.com>,
	"Robert P. J. Day" <rpjday@mindspring.com>,
	Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <20040629143715.2AF7EC109F@atlas.denx.de>
References: <20040629143715.2AF7EC109F@atlas.denx.de>
Content-Type: text/plain
Message-Id: <1088526722.14216.1585.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Tue, 29 Jun 2004 17:32:02 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 2004-06-29 at 16:37 +0200, Wolfgang Denk wrote:
> In message <40E164A6.8060502@246tNt.com> you wrote:
> >
> > I'd suggest having a look at the comment on top of
> >
> > drivers/mtd/cmdlinepart.c
> >
> > But I'm not sure if rpxlite.c . From what I see, it may require to add
> > a "probe" to look at the command line. Someone ?
>
> It's tested and working in our version of the linuxppc_2_4_devel tree.

Please could you commit this to my CVS tree. It'll make its way to Linus
in time -- I need to do an update of MTD code for Linus fairly soon for
other reasons.

--
dwmw2


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
