Message-ID: <3AB9CAE4.F92F3A6B@inn.ericsson.se>
Date: Thu, 22 Mar 2001 10:50:28 +0100
From: Kenneth Johansson <kenneth.johansson@inn.ericsson.se>
MIME-Version: 1.0
To: frowand@mvista.com
Cc: Dan Malek <dan@mvista.com>,
	Matthias Fuchs <matthias.fuchs@esd-electronics.com>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>,
	frank@esd-electronics.com
Subject: Re: possible problem in memory management
References: <3AB8B894.1C5FCD37@esd-electronics.com> <3AB9148A.7F25E9A0@mvista.com> <3AB9254E.FE13F585@mvista.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Frank Rowand wrote:
>
> Dan Malek wrote:
> >
> > Matthias Fuchs wrote:
> >
> > >   CPU:   IBM PowerPC 405GP Rev. C at 198 MHz (PLB=99, OPB=49, EBC=33 MHz)
> >
> > Get yourself an up to date Rev. D CPU.  The Rev. C workarounds in
> > the kernel were reasonable attempts, but probably aren't complete.
>
> Dan is correct.  We did not do an exhaustive scan of the kernel to add
> workarounds in all places they might be necesary, just enough to make the
> kernel fairly stable and usable.  Even in the places where the workarounds
> are in place, they are not guaranteed to be 100% effective.

But I do think there is a memory bug inte the version of the kernel he is using.
I can produce a error state at will running debian (potato) on that kernel.
Running emacs or simply login over telnet puts it into that state. I currently
is not working to resolv the problem so I don't have more infomation than that
it fails, sorry.




--
Kenneth Johansson
Ericsson Business Innovation AB   Tel: +46 8 404 71 83
Viderögatan 3                     Fax: +46 8 404 72 72
164 80 Stockholm                  kenneth.johansson@inn.ericsson.se

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
