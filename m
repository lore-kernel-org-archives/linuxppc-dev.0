To: "Stephan Linke" <Stephan.Linke@epygi.de>
Cc: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: problems running I2C and/or SPI on 857 board 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 26 Mar 2002 11:03:47 +0100."
             <FCEAKDJJAPHPLJFINDAJEENDCDAA.Stephan.Linke@epygi.de>
Date: Tue, 26 Mar 2002 11:29:45 +0100
Message-Id: <20020326102950.BDF16109F3@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <FCEAKDJJAPHPLJFINDAJEENDCDAA.Stephan.Linke@epygi.de> you wrote:
>
> At the moment all my tries are based on the existing drivers in PPCBOOT.

Which version of PPCBoot? The official releases (1.1.5)  should  work
just fine; they do so on several tested systems.

If you're using the top of tree on the CVS server (i. e. the  version
which includes the "Grand Unifying I2C interface patch") you may have
to  adjust a couple of things; this is not that well tested / working
yet.

> Using no microcode patch, and DPRAM allocation.

I wonder why you use the CPM code at all.  I  always  found  it  much
easier to use CONFIG_SOFT_I2C ...

> DPRAM allocation pointed out a bug so I guess it's not that well tested yet
> :( .
> Trying fixed DPRAM offsets and microcode now...

Please submit a patch!

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The price of curiosity is a terminal experience.
                         - Terry Pratchett, _The Dark Side of the Sun_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
