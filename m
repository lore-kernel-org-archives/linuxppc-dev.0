Message-ID: <389EE56C.47EEBDE@haulpak.com>
Date: Mon, 07 Feb 2000 09:31:56 -0600
From: William Gatliff <gatliff@haulpak.com>
MIME-Version: 1.0
To: all@cideas.com, linuxppc-embedded@lists.linuxppc.org,
        gdb@sourceware.cygnus.com
Subject: Re: [Looking for the PPC gdb debug stubs]
References: <Pine.SGI.3.95.1000207100549.24603E-100000@world.std.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Aleksey:

> > > - If so, where can I find the PPC gdb debug stubs?
>
> You can try the thing I put togehter at
> http://www.std.com/qqi/labslave/rproxy.html
>
> Among other things it provides an application bridge between wiggler (BDM
> debugger from macraigor) and gdb remote protocol.

Yes, that's an even better solution than a stub, on targets and platforms that can
support it, becuase it does in hardware what the stub does in software.

b.g.

--
William A. Gatliff
Senior Design Engineer
Komatsu Mining Systems
To teach is to learn.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
