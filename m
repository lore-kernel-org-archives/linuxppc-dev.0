Message-Id: <5.1.0.14.2.20030421091806.0356ccf0@mail.ebshome.net>
Date: Mon, 21 Apr 2003 09:27:09 -0700
To: KISHINAMI Masaya <kishinami@cs.fujitsu.co.jp>
From: Eugene Surovegin <ebs@ebshome.net>
Subject: Re: [PATCH][BUGFIX][2.4.21] Fix PPC4xx Ethernet problem 
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <200304211335.AA02623@kishinami.cs.fujitsu.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 06:35 AM 4/21/2003, KISHINAMI Masaya wrote:

>Attached file is effective the failure not to generate the receive
>completion interruption from EMAC to 405GP On-chip LAN device driver.
>The failure condition is as follows.
>
>- custom board designed based on the 405GP
>- kernel 2.4.18
>- 2.4.21 pre3 ibm_ocp LAN device driver and ported it to
>   work on kernel 2.4.18
>- repeater hub(10Mbps, half duplex)
>- line is much loaded
>
>The modification was applied from 2.4.21 pre3.
>Please see the follows URL. It describes in detail.
>http://lists.linuxppc.org/linuxppc-embedded/200304/msg00171.html
>Please apply attached file.

This change looks very strange.

1) Did you try your tests on the reference 405GP board (Walnut) ?
    Maybe it's not a driver problem but your custom board.

2) Did you contact IBM? If yes, what did they say?

3) Did you try new PPC 4xx ethernet driver in linuxppc-2.4 tree
(bk://ppc.bkbits.net/linuxppc-2.4)?

Thanks,

Eugene


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
