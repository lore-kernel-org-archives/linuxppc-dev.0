Message-ID: <38CAC97F.4F45265A@denise.shiny.it>
Date: Sat, 11 Mar 2000 17:32:31 -0500
From: Giuliano Pochini <pochini@denise.shiny.it>
MIME-Version: 1.0
To: David Edelsohn <dje@watson.ibm.com>
CC: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        Sean Harding <sharding@dogcow.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: compiler optimization? something else?
References: <200003091604.LAA24832@mal-ach.watson.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




> Franz> -O2, -O3, -funroll-loops, -funroll-all-loops, -ffast-math (dunno if this
> Franz> one has an effect on PPC at all), -finline-functions, -mcpu=604, -mcpu=750
>
>         -ffast-math does enable use of the FP "fsel" instruction for
> conditional moves.  -ffast-math also affects other floating-point
> optimizations in the compiler, not just specific architecture features.

And mul-add's & friends ?

Bye.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
