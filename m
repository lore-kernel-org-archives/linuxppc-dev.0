Subject: Re: [PATCH] Permedia2 fb on PPC
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
To: mzyngier@freesurf.fr
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <wrpadwxth3m.fsf@hina.wild-wind.fr.eu.org>
References: <wrpsnaq0xkx.fsf@hina.wild-wind.fr.eu.org>
	<1007572780.21734.65.camel@pismo>
	<wrpadwxth3m.fsf@hina.wild-wind.fr.eu.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: 08 Dec 2001 22:47:54 +0100
Message-Id: <1007848074.9125.10.camel@pismo>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2001-12-05 at 23:52, Marc ZYNGIER wrote:
> >>>>> "Michel" == Michel Dänzer <michdaen@iiic.ethz.ch> writes:
>
> Michel> Why is this needed?
>
> Because it simply crashes the system without it ;-).
>
> This prevent the driver from using a non-existant (at least on the
> board I own) big endian aperture for registers.

Oh my...


> Michel> And does it work with the XFree86 glint driver with Option
> Michel> "UseFBDev"?
>
> Don't know yet. _Now_ that I have a console (thanks to this patch),
> I'll have a look at the X11 thingy.

Well at least when I last worked on the glint driver, it relied on the
register aperture being big endian.


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
