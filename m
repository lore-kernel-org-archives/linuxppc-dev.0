Message-ID: <3EE0AEFC.8EA62FB0@opersys.com>
Date: Fri, 06 Jun 2003 11:10:52 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
MIME-Version: 1.0
To: Lokesh Kumar <lokesh.kumar@wrx-us.com>
Cc: brian.auld@adic.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: x86(host) --> ppc(tgt) cross-tool-chain
References: <3439AB3A99ECD5409F3A52ACF814744D158D22@norcom2.norcom.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Lokesh Kumar wrote:
> I built the toolchain on x86 host for PPC, and I used
>
> GCC-2.95.3
> GLIBC-2.2.3
> Binutils-2.11.92
>
> I did not use Karim's book. I went with "Embedded Linux Interfacing ...."
> book.

:)

I have to ask: Did this toolchain actually work for you on the target?
I mean, did you try using glibc-2.2.3 on the PPC target? From I've
seen, gcc 2.95.3 with glibc 2.2.3 will successfully generate a glibc,
but the resulting glibc will core dump on the target.

Karim

--
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 514-812-4145

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
