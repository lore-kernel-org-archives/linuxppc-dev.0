Message-ID: <38DB969A.E5088271@ocegr.fr>
Date: Fri, 24 Mar 2000 17:23:54 +0100
From: Zirong WANG <zirong.wang@ocegr.fr>
MIME-Version: 1.0
To: Cort Dougan <cort@fsmlabs.com>
CC: "Dan A. Dickey" <ddickey@charter.net>,
        "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Anyone tried 2.3.99.pre?
References: <38DAB8D3.F930393@charter.net> <20000323174654.B11626@medea.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi everybody,

Cort Dougan wrote:
>
> The latest v2.3.99-pre3-pre7 works on PPC.  8xx doesn't work since it's not
> finished in 2.3.

I am just wondering when this release will be merged in the
kernel.org tree for easy downloading. I am looking for a version
of PPC linux that deals well with IDE disk on my MTX board.

>
> } Just was curious and was wondering if anyone has
> } been following the 2.3 kernel development.  2.3.99.pre
> } is out, and so it appears as if 2.4 is imminent.
> } Does the 2.3.99.pre-anything work out of the box
> } on some powerpc?  I realize this probably isn't
> } quite appropriate for the embedded list, but it's
> } the list that I spend most of my time around right now.

I have tried the 2.3.99.pre3 (from kernel.org, of 24 mars), I could not
even compile it on my MTX 603 machine which works well with 2.2.13,
except for IDE disks.

The compile error is about ncr53c8xx.c with 'base_io' not defined.

Zirong

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
