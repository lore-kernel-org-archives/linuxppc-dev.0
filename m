Subject: Re: linuxppc-2.5 rsync tree broken
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Harald Welte <laforge@gnumonks.org>,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20020820143837.GA891@opus.bloom.county>
References: <20020819200140.A9590@sunbeam.de.gnumonks.org>
	<20020820143837.GA891@opus.bloom.county>
Content-Type: text/plain; charset=ISO-8859-1
Date: 20 Aug 2002 16:44:50 +0200
Message-Id: <1029854690.691.76.camel@cube>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2002-08-20 at 16:38, Tom Rini wrote:
>
> On Mon, Aug 19, 2002 at 08:01:40PM +0200, Harald Welte wrote:
>
> > The current (at least yesterday and today) linuxppc-2.5 tree at
> > source.mvista.com is broken.
> >
> > It is totally missing the directories sound/core and drivers/usb/core.
>
> What flags are you passing to rsync?  Both of those directories exist in
> the tree rsync serves from.

core makes me think of -C alias --cvs-exclude.


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
