Subject: Re: xgamma
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
To: Giuliano Pochini <pochini@denise.shiny.it>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <3C2DD464.423D350C@denise.shiny.it>
References: <3C2DC85D.145B4873@denise.shiny.it>
	<1009634451.2103.4.camel@pismo>  <3C2DD464.423D350C@denise.shiny.it>
Content-Type: text/plain; charset=ISO-8859-1
Date: 29 Dec 2001 20:16:30 +0100
Message-Id: <1009653390.993.6.camel@pismo>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 2001-12-29 at 15:34, Giuliano Pochini wrote:
>
> > > xgamma has no effect with 2.4.17.
> >
> > I assume you're talking about aty128fb and running X with Option
> > "UseFBDev". Ben seems to have decided not to support this unfortunately.
>
> Yep.  Workarounds ?

Use an older aty128fb where it at least kinda works, or don't use Option
"UseFBDev" (broken with 4.1).


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
