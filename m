To: Adam Wozniak <adam.wozniak@comdev.cc>
Cc: Borracini Evandro-R45188 <Evandro.Borracini@motorola.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: dynamically linked Init hanging 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 16 Oct 2001 14:18:05 PDT."
             <3BCCA40D.40AB5016@comdev.cc>
Date: Tue, 16 Oct 2001 23:29:48 +0200
Message-Id: <20011016212953.37E2710889@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3BCCA40D.40AB5016@comdev.cc> you wrote:
>
> > (patching glibc for the cache line size
>
> I've never heard of this one before.  Is it in the FAQ?

Of course. Didn't you find it? Just search for "cache" ;-)

See http://penguinppc.org/embedded/howto/library.html#GLIBC,
section 12.1. glibc:

    ...
    Some modifications are required to the official glibc-2.1.x
    releases to make them work in the embedded PowerPC environment,
    such as cache line size modifications. See
    http://lists.linuxppc.org/listarcs/linuxppc-embedded/199909/msg00000.html

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The easiest way to figure the cost of living is to take  your  income
and add ten percent.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
