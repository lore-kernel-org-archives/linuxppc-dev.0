Message-Id: <v03110700b4cc8fce0321@[209.183.136.12]>
In-Reply-To: <200002130440.XAA25134@mal-ach.watson.ibm.com>
References: Message from Kevin Hendricks <khendricks@ivey.uwo.ca>    of
 "Sat, 12 Feb 2000 23:21:41 EST."
 <00021223332100.19021@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 13 Feb 2000 11:51:20 -0500
To: David Edelsohn <dje@watson.ibm.com>, linuxppc-dev@lists.linuxppc.org
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Subject: Re: Kernel Gurus Help! Possible kernel bug in conversion of
 jiffees in nanosleep.
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

>	Maybe submit the question to the glibc-alpha mailinglist as well?
>
>David

I submitted two bug reports about this via the glibc bug database.

The second report just adds info about the first.

The bug reports are 1597 and 1598.

I have previously fixed pthread_cond_timedwait in glibc 2.1.3 to actually
work recently but a final "cleanup" recently committed patch rewrote things
so that it no longer worked.

The funny thing is that their technique *should* work if the remtime value
from nanosleep would actually decrease and not increase.

So I think the whole thing is actually a kernel bug but I am not sure.

I know nothing about jiffees and their conversion to and from time values
and I am not sure how jiffees could ever grow (lost jiffees added back?).

If anyone who knows something about jiffees and conversions could look at
nanosleep I would greatly appreciate it.

Thanks,

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
