Message-ID: <393BB0F5.415E62C8@aminocom.com>
Date: Mon, 05 Jun 2000 13:53:57 +0000
From: Elizabeth Clarke <eclarke@aminocom.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Java
References: <200006021710.NAA19138@hoover.gilbarco.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Banks, Kelly" wrote:
> I was hitting the exact same error & wound up tracking it into the
> libtermcap.2.0.8 that I was using...  Mine went away when I used the termcap
> available from Mvista.

Hmmm, didn't make any difference. But then I dont understand what
difference it could make. AIUI anything compiled with egcs ie the JDK
binaries are incompatible with anything compiled with gcc  - my
libraries, because egcs
referenced the symbol register_frame_info. I tried making a library with
just that symbol and pre-loading it, but still got the error:

/usr/jre118-v2/bin/ppc/green_threads/jre: error in loading shared
libraries: /usr/jre118-v2/lib/ppc/green_threads/libjava.so: symbol
__register_frame_info, version GLIBC_2.0 not defined in file libc.so.6
with link time reference

I think I'm going to have to investigate the JDK-1.2.2 and glibc-2.1.3
from
Franz Sirl's site, unless I'm missing something completely?...
(probably!)

Beth

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
