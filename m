Message-ID: <XFMail.000714115828.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
Date: Fri, 14 Jul 2000 11:58:28 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: linuxppc-dev@lists.linuxppc.org
Subject: lmbench & segfaults
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi! When I run lmbench on a PC I get these line at the beginning:


>Hang on, we are calculating your timing granularity.
>OK, it looks like you can time stuff down to 5000 usec resolution.
>
>Hang on, we are calculating your timing overhead.
>OK, it looks like your gettimeofday() costs 0 usecs.
>
>Hang on, we are calculating your loop overhead.
>OK, it looks like your benchmark loop costs 0.00000000 usecs.

But with my G3 or my PMac7300 I get a segfault for each of them... Why ?

[kernels 2.2.12-2.2.14]

Bye.
    Giuliano Pochini ->)|(<- Shiny Corporation {AS6665} ->)|(<-


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
