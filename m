Message-ID: <XFMail.010413103837.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <20010412162639.K2127@plato.local.lan>
Date: Fri, 13 Apr 2001 10:38:37 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Ethan Benson <erbenson@alaska.net>
Subject: Re: boot params
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> I'm trying to make the new aic7xxx driver work on my blue G3 and I
>> need to pass boot parameters to the kernel. I'm using yaboot. How
>> can I do ? Am I the only one who has problems with the new driver ?
>
> in your image= section:
>
>       append="whatever"

Ok.

> and rerun ybin.

Do you rerun ybin ?  I just change yaboot.conf and it works.

> which new driver are you referring to?  in 2.4?

The new aic7xxx (v6.1.x).

> i have never had to
> do anything special to get this driver working on my blue g3 with a
> 2930.

I have problem with devices running at different clocks on the same bus.
v6.1.11 hangs during bus scanning.


Bye.
    Giuliano Pochini ->)|(<- Shiny Network {AS6665} ->)|(<-


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
