Message-ID: <6B546A602AD2D211BFF00008C7A42889041D6C95@hrtades2.atea.be>
From: Goddeeris Frederic <Frederic.Goddeeris@siemens.atea.be>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: gdb problems / BDM PPCBoot 
Date: Tue, 30 Oct 2001 09:59:50 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Just for the record: it works better with the compiler that MontaVista
includes in their 2.0 CDK; no -ggdb needed.

Fred

-----Original Message-----
From: Goddeeris Frederic
Sent: vrijdag 12 oktober 2001 16:25
To: 'Wolfgang Denk'
Subject: RE: gdb problems / BDM PPCBoot


Thanks!

-----Original Message-----
From: Wolfgang Denk [mailto:wd@denx.de]
Sent: vrijdag 12 oktober 2001 12:53
To: Goddeeris Frederic
Subject: Re: gdb problems / BDM PPCBoot


Dear Frederic,

in message <6B546A602AD2D211BFF00008C7A42889041D6C75@hrtades2.atea.be> you
wrote:
>
> I also need the -ggdb to debug applications remotely. The MontaVista FAQ
> mentions that this is needed due to a problem in the compiler shipped with
> CDK 1.2; I suppose it is no longer needed for the recent compilers they
> provide.

Well, upgrade to HHL-2.0.2, then...

> I am sorry to ask a question that was discussed many times, but to be
honest
> I did not find a lot a threads when I search for "ddd", "gdb, "BDM" or
> "Abatron". Where do I look?

I'm sorry - I know that the search functions for the mailing list are
pretty useless, but I cannot help it. Please  complain  to  the  list
maintainer.

> I have read your mail where you mention:
...
That's exaclty what I do

> Forgive me my cluelessness, but the very early code is, _init_board, the
> code is still running from flash, right, so just starting with
> "powerpc-linux-gdb ppcboot" should work?

Yes, that's what it does for me on all boards.

Hope this helps,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Always borrow money from a pessimist; they don't expect  to  be  paid
back.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
