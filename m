To: Bret Indrelee <Bret.Indrelee@qlogic.com>
Cc: Kent Borg <kentborg@borg.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: IO, ANSI vs GCC structs 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 25 Jul 2003 10:51:19 CDT."
             <Pine.LNX.4.44.0307251038370.22864-100000@spider.ancor.com>
Date: Fri, 25 Jul 2003 18:19:35 +0200
Message-Id: <20030725161940.41FDEC602D@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <Pine.LNX.4.44.0307251038370.22864-100000@spider.ancor.com> you wrote:
>
> > Does GCC make guarantees beyond what ANSI requires?  Is there some
> > subtle detail that forces struct layout ("volatile" in the definition
> > perhaps)?
>
> There is nothing that guarentees this, in ANSI or GCC.

You can use "__attribute__ ((packed))" with GCC which  guaratees  you
control  over  the  alignment  used  by the compiler (it will use the
smallest possible alignment = one byte for a variable,  and  one  bit
for  a  field,  unless  you specify a larger value with the `aligned'
attribute).


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The human race has one really effective weapon, and that is laughter.
                                                         - Mark Twain

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
