To: acurtis@onz.com
Cc: "Flavio Pereira" <fpereira@azisa.com>,
	"Yu Bo-BOYU1" <Bo.Yu@motorola.com>,
	"linuxppc embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 8260 configuration 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 02 Oct 2002 07:27:20 PDT."
             <NCBBIINEHIPFGJPLBEIFCEMKDMAA.acurtis@onz.com>
Date: Wed, 02 Oct 2002 16:47:52 +0200
Message-Id: <20021002144757.8BCDFFA99@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <NCBBIINEHIPFGJPLBEIFCEMKDMAA.acurtis@onz.com> you wrote:
>
> > > 2. The start address is fixed to 0x0
> > >
> >
> > One "start" address that is not fixed is the initial load
> > address. Where the
> > kernel is put in RAM with decompressing etc. You should have to
> > worry about
> > this if you are using one of the available boot loaders.
>
> Sorry, should NOT have to worry about that address...

Wrong, you SHOULD worry about this address. Load the kernel to a  low
enough  address  (say  at  0x10000)  and  the uncompressing code will
probably overwrite the kernel image.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
If the facts don't fit the theory, change the facts.
                                                   -- Albert Einstein

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
