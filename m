Date: Tue, 26 Mar 02 17:35:50 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0203270135.AA02861@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Mark A. Greer <mgreer@mvista.com> wrote:

> [3] tag: BI_STRUCT                      (embedded enet cltr 0)
>     size: 76                            (12 + 3*12 + 25 + 3 == 76)
>     data: BI_DEVICE
>
>     [3.0] tag: BI_DEV_TYPE
>           size: 12
>           data: BI_DEV_EMBEDDED
>
>     [3.1] tag: BI_DEV_CLASS
>           size: 12
>           data: BI_CLASS_ENET
>
>     [3.2] tag: BI_DEV_ID
>           size: 12
>           data: 0                       (1st enet device)
>
>     [3.3] tag: BI_MAC_ADDR
>           size: 25
>           data: aa:bb:cc:dd:ee:ff       (ascii)
>     pad: 3

[Skipped identical structs for the other two ports]

I disagree. I think BI_GT64260_ETH_CFG as I implemented it is better.

Now if you actually implement your way in code and make it work, I'll accept it
even though I dislike it, but if your above proposal remains verbiage, my patch
must be pushed instead. Unimplemented verbiage must not take precedence over
working code.

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
