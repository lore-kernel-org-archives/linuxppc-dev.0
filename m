Subject: Re: aic7xxx panics (long)
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20030702075932.GR930@plato.local.lan>
References: <3EFFD86B.7060007@stinkfoot.org>
	 <1056957083.32576.112.camel@gaston> <3F00E86B.1000309@stinkfoot.org>
	 <1057053589.32576.310.camel@gaston> <3F02537C.1090801@stinkfoot.org>
	 <20030702075932.GR930@plato.local.lan>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1057135182.2577.13.camel@thor.holligenstrasse29.lan>
Mime-Version: 1.0
Date: 02 Jul 2003 10:39:44 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2003-07-02 at 09:59, Ethan Benson wrote:
> On Tue, Jul 01, 2003 at 11:37:32PM -0400, Ethan Weinstein wrote:
> >
> > Even with your suggestions, I was unable to get xmon to output
> > correctly, the framebuffer became too corrupted to get anything useful,
> >  and the sysmap option couldn't have worked if we couldn't mount
> > anything anyway, no?
>
> actually the sysmap= option is handled internally by yaboot, yaboot
> reads the sysmap into memory and gives the kernel a pointer to it.
> the kernel doesn't read it from disk itself.
>
> its also not really tested at all so its entirely possible thats its
> completly broken ;-)

It's been working perfectly here.


--
Earthling Michel Dänzer   \  Debian (powerpc), XFree86 and DRI developer
Software libre enthusiast  \     http://svcs.affero.net/rm.php?r=daenzer


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
