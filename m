Message-ID: <392162B4.CDD36DE7@mondonet.net>
Date: Tue, 16 May 2000 17:01:08 +0200
From: Mario Scarpa <m.scarpa@mondonet.net>
MIME-Version: 1.0
To: Bernhard Reiter <bernhard@intevation.de>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Lombard hard freeze (update: mem>64MB)
References: <20000511150009.D8481@cheops.usf.Uni-Osnabrueck.DE> <Pine.SUN.4.21.0005140159110.4879-100000@panix.com> <20000515105218.C4202@cheops.usf.Uni-Osnabrueck.DE>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Bernhard Reiter wrote:

> Mario Scarpa            hard freeze as described?  64 MB + other problems

Hi Bernhard,

I was out for a while, now I'm back.
My config is like the following:
Lombard 400MHz with 64MB (from Apple) running 2.2.15pre20 on Debian 2.2.

I'm experiencing (seldom) freezes with this config when I have
some heavy network activity and, even more seldom, when the
system boots up and initialize the serial driver.
My problems started when I compiled the USB driver into the kernel
(or, at least, began to be visible).

No problem during any compilation (and I do quite a lot of this)...

--
Mario Scarpa

Mondonet NOC
Phone: +39 06 52.47.37.02

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
