Mime-Version: 1.0
Message-Id: <v04220802b629867e2b7e@[10.0.0.42]>
In-Reply-To: <19340928215218.14436@192.168.1.10>
References: <3A037737.2B131815@denise.shiny.it>
 <19340928215218.14436@192.168.1.10>
Date: Sat, 4 Nov 2000 01:28:06 -0800
To: Benjamin Herrenschmidt <bh40@calva.net>,
        Giuliano Pochini <pochini@denise.shiny.it>,
        <linuxppc-dev@lists.linuxppc.org>
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: 2.2.18p19
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 5:20 AM +0100 11/4/00, Benjamin Herrenschmidt wrote:

>Also, I don't think the boot protocol USB drivers will do any good for
>you, especially if you use ADB-like keymaps. You should probably use the
>HID drivers, as those were well tested on macs.

Not only that, but they seem to work better on PCs too.  I have
multiple computers, and a nifty KVM switch which is based on USB so
that I can easily share one USB keyboard & mouse among all my
computers even though one is a cheap PC and the others are Macs.  I
had problems with RH7 on the PC (wouldn't recognize the USB keyboard)
until I recompiled the kernel and selected HID instead of HIDBP.

   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
