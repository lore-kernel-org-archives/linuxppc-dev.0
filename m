Message-ID: <3AB8E0AD.9D13A309@mvista.com>
Date: Wed, 21 Mar 2001 09:11:10 -0800
From: Cal Erickson <cal_erickson@mvista.com>
Reply-To: cal_erickson@mvista.com
MIME-Version: 1.0
To: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
Cc: Frank Rowand <frank_rowand@mvista.com>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: compiler warning
References: <3AB8BA72.333D5D74@esd-electronics.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Matthias,
This is a warning that the attributes for a section which
the linker creates when the link is done has had its
initial attributes changed. We at MontaVista have seen
this and we will be posting a fix with our HHL 2.0 release.
It is only a warning and will not affect the executable code.

Cal
Matthias Fuchs wrote:

> Hi,
>
> I do not understand this compiler warning:
>
> /tmp/ccu149sf.s: Assembler messages:
> /tmp/ccu149sf.s:5: Warning: Ignoring changed section attributes for
> .modinfo
>
> It appears everytime, when I use the ppc_4xx-gcc from MontaVista.
> What does it mean ? Do I have to take care aboutit ?
>
> Matthias
>
> --
> -------------------------------------------------
> \ Matthias Fuchs                                 \
>  \ esd electronic system design Gmbh              \
>   \ Vahrenwalder Straße 205                        \
>    \ D-30165 Hannover                               \
>     \ email: matthias.fuchs@esd-electronics.com      \
>      \ phone: +49-511-37298-0                         \
>       \ fax:   +49-511-37298-68                        \
>        --------------------------------------------------
>

--
===========================================================================
Cal Erickson                 MontaVista Software Inc.
Linux Consultant             1237 E. Arques Ave.
Phone (408) 328-0304         Sunnyvale CA 94085
Fax   (408) 328-9204         web http://www.mvista.com
eCode: http://cal@work.com.ecode.com
===========================================================================


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
