To: "Mark A. Greer" <mgreer@mvista.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 19 Mar 2002 16:12:33 EST."
             <3C97A9C1.EBA150B6@mvista.com>
Date: Wed, 20 Mar 2002 00:36:30 +0100
Message-Id: <20020319233635.2E203109F3@denx.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <3C97A9C1.EBA150B6@mvista.com> you wrote:
>
> > How about my proposal to replace MEMSIZE and  MEMSTART  with  a  more
> > general description which allows for _several_ memory areas, probably
> > of  different type (RAM, ROM, Flash, SRAM, ...), different bus witdth
> > etc. ?
>
> I think its a good idea but overkill for now isn't it ("now" being 2.4 since
> its going to change in 2.5)?
...
> Can we push this off into 2.5?  I was hoping to keep it fairly simple and
> just get it done in 2.4.

The systems I see shipping in the next 6 months or so will  be  based
on 2.4 kernel; I think we should define this feature rather sooner or
later to try it out and get it right.

Of course, we can always add this locally, but why not do it now when
we know it needs to get done?

> But every board/driver can still use the console=xxx on the cmd line, right?
> Can we get by with that?

The command line is pretty limited in leght, and there are many  more
"interesting"  things  you want to pass to proprietary drivers etc. I
rather had common stuff like this somewhere else...

> The only reason I'm pushing for simple bi_recs now is because I expect all
> this to change significantly in 2.5.  If you want the 2.5 way back-ported to
> 2.4 and everyone agrees that's what should be done, then I agree we should do
> it the "right way" now.  Otherwise, I say do the minimum now and do it right
> in 2.5.

If you ask for my opinion: let's do it right NOW, and stick with this
in 2.5, rather than wasting some work  now  for  a  preliminary  ugly
solution  which we think will get thrown avay (which might not happen
as expected), and then spending even more work to do it right.

If you know what  the  final  version  will  look  like,  then  let's
implement this now. And be done with it.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Above all else -- sky.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
