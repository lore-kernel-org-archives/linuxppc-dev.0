Message-ID: <40B7318F.3020309@intracom.gr>
Date: Fri, 28 May 2004 15:33:19 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: newly-updated linuxppc-2.5 tree compiles but fails to boot
References: <Pine.LNX.4.58.0405280746270.26869@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.58.0405280746270.26869@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Robert P. J. Day wrote:

>  just this morning, i did a fresh checkout of the linuxppc-2.5 BK repo
>and, using the same .config file as i have for a while, got a clean
>compile (yee ha), building for 8xx.
>
>  sadly, unlike previous times where i could then boot that kernel up to
>user space, this kernel hung almost immediately:
>
>Linux/PPC load: console=ttyS0,9600 rw root=/dev/ram0 init=/bin/sh
>Uncompressing Linux...done.
>Now booting the kernel
>
>... and that was it.  just as i head back to check things out more
>carefully, would any of the recent changes require any obvious mods to the
>config file?  sorry i'm not enough of a kernel expert to know how to dig
>into this further, but i'm working on it.
>
>
>rday
>
>
>
>
>
Hold your horses.

While my tree based on 2.6.6 is working as of the last update to
2.6.7-rc1 it is broken.

Currently investigating...

Regards

Pantelis


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
