Message-ID: <39C80065.4741C043@mvista.com>
Date: Tue, 19 Sep 2000 20:10:13 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Roman Zippel <zippel@fh-brandenburg.de>
CC: paulus@linuxcare.com.au, Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
References: <Pine.GSO.4.10.10009200107220.9268-100000@zeus.fh-brandenburg.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Roman Zippel wrote:

> Fixed addresses shouldn't be that much of a problem.

They are no problem today....It would be nice if it stayed that way :-).

> .... we would only need a C implementation from parts hashtable.S,
> what might be usefull for other stuff as well.

Except only the 7xx (601?, 604) use the hastable.  It's not a generic
MMU place.

> Something I would like to throw out first is mem_pieces.c....
> ... pmac_find_end_of_memory(), which then is completly confused,

I am usually confused by this point, too :-).  I then just tip-toe
away thinking there are better places I can spend my time.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
