Message-ID: <3A4D37D6.6BAA22C3@mvista.com>
Date: Fri, 29 Dec 2000 20:18:14 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Ron Bianco <ronb@junction.net>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: A stable linux 2.2.xx for sandpoint-8240 anywhere?
References: <000901c071ef$85b814d0$4d012ac7@warp-speed>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ron Bianco wrote:

> We do now need something suitable for a product.

There are ways......expecting free downloaded experimental software
probably isn't the best choice to start.

> ........  Since then (feb 2000) there have been over
> 100 sets of patches to the linux kernel.

Maybe more like 1000, or 10,000.  I think I did the original 8240
port back in August 1999.  I have added more than 100 patches
since then.

> ...apply the changes to the stable 2.2.18 kernel,

That would be my suggestion.

> ...... or apply the
> changes to the almost stable 2.4.0-test12, the totally latest kernel
> version as of last week.

Acutally, I think it is -test13, but I wouldn't use 2.4 unless you
needed some of the new features (and most people want them).

> We'll probably wait to see what those are, so as to avoid duplication.

It's basically what is in the 2.2.x brought up to 2.4.  Nothing much.



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
