Message-ID: <XFMail.001009181300.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <Pine.GSO.4.21.0010091229310.24725-100000@stekt6>
Date: Mon, 09 Oct 2000 18:13:00 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Topi Kanerva <tkanerva@ees2.oulu.fi>
Subject: Re: can't boot 2.4.0-t9
Cc: linuxppc-dev@lists.linuxppc.org,
        Giuliano Pochini <pochini@denise.shiny.it>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>I can't boot kernel 2.4.0-test9 because it fails configuration
>>of my scsi cards (resource collisions). The hack of removing the
>>"return -EINVAL" I used in test7 doesn't work anymore.  Anyway,
>>I'm just curious to know why there are not such problems in 2.2.
>
> is this the plain 2.4.0-test9 or linuxcare devel version?

Plain version, d/l fron kernel.org

> If I were you, I'd try to backport the test7 scsi code to make
> the hack work again.

A function (I don't remember which) have a different number of
parameters and it doe't compile. I'll try again this night.


Bye.
    Giuliano Pochini ->)|(<- Shiny Corporation {AS6665} ->)|(<-


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
