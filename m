Date: Mon, 9 Oct 2000 12:33:06 +0300 (EET DST)
From: Topi Kanerva <tkanerva@ees2.oulu.fi>
To: Giuliano Pochini <pochini@denise.shiny.it>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: can't boot 2.4.0-t9
In-Reply-To: <39E0C4B7.612575E@denise.shiny.it>
Message-ID: <Pine.GSO.4.21.0010091229310.24725-100000@stekt6>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 8 Oct 2000, Giuliano Pochini wrote:

>I can't boot kernel 2.4.0-test9 because it fails configuration
>of my scsi cards (resource collisions). The hack of removing the
>"return -EINVAL" I used in test7 doesn't work anymore.  Anyway,
>I'm just curious to know why there are not such problems in 2.2.

is this the plain 2.4.0-test9 or linuxcare devel version?
If I were you, I'd try to backport the test7 scsi code to make
the hack work again.
I don't know about the drivers/scsi stuff, because I have a pismo
(and hence no scsi), but for sure none of the 2.4.0-testx kernels
have worked for me in terms of X: if I start X (4.0.1c), the
lcd screen goes black, or then just completely wild.

Can anyone else with a pismo confirm this?

-topi


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
