Date: Fri, 11 Jul 2003 02:58:17 -0500 (CDT)
Message-Id: <200307110758.h6B7wHe6096683@sullivan.realtime.net>
To: linuxppc-dev@lists.linuxppc.org
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] include for CONFIG_SWAP=n
In-Reply-To: <h6B6ZV3o095338@sullivan.realtime.net>
Cc: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> With CONFIG_SWAP=n, I get
>
> include/asm-generic/tlb.h:76: warning: implicit declaration of function `release_pages'
>  ...
>
> One can argue for putting this somewhere generic, but I took the easy approach.

Indeed the abvoe doesn't fix the general case because the error is in
a static inline.  I'll do a better generic fix sometime.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
