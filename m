Message-ID: <3A76D9D1.A530BD6F@inn.ericsson.se>
Date: Tue, 30 Jan 2001 16:12:17 +0100
From: Kenneth Johansson <kenneth.johansson@inn.ericsson.se>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
CC: Jerry Van Baren <vanbaren_gerald@si.com>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: Initial stack frame
References: <200101301446.f0UEkTO10556@denx.local.net>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:
>
> In message <4.3.2.20010130074919.00bb0a80@falcon.si.com>
> Jerry Van Baren wrote:
> >
> > One of the differences between the ABI and EABI is that the EABI
> > requires 8 byte alignment of the stack and the ABI requires 16 byte
> > alignment (EABI, p.28).
>
> Yes, ok. But what is implemented by GCC and glibc? The SVR4 ABI or
> the EABI?
>
> In other words: Wolfgang Grandegger wants to know if  we  must  align
> "private" stack frames on 8 or 16 byte boundaries...
>
> Wolfgang Denk
>

linux implements SVR4 with exceptions that we don't return small(8 or less
bytes) structs in r3,r4 as the standard say we should. Could be more things I
have not noticed we are anyway closer to SVR4 than EABI.


--
Kenneth Johansson
Ericsson Business Innovation AB   Tel: +46 8 404 71 83
Viderögatan 3                     Fax: +46 8 404 72 72
164 80 Stockholm                  kenneth.johansson@inn.ericsson.se

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
