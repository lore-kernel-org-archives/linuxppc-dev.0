Message-ID: <20031201190828.20157.qmail@web40911.mail.yahoo.com>
Date: Mon, 1 Dec 2003 11:08:28 -0800 (PST)
From: Brian Kuschak <bkuschak@yahoo.com>
Subject: Re: routing performance w/embedded linux on ppc?
To: "Vladimir A. Gurevich" <vag@paulidav.org>
Cc: linuxppc-embedded@lists.linuxppc.org, linuxppc@opqua.com
In-Reply-To: <3FC59BAE.3020801@paulidav.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Vlad,

>
> Starting with 2.4.19 or so, I'd recommend looking at
> NAPI to do
> interrupt mitigation instead. Please look at
> ftp://robur.slu.se/pub/Linux/net-development/NAPI/
>

Yes, it looks interesting!  I'm glad this is being
introduced as a mechanism for all drivers to use.

I haven't had time to study it in detail, but I'm a
little concerned about NAPI using the softirq context.
 In the 2.4 kernels I've seen various performance
issues related to ksoftirqd.  Perhaps this has been
fixed in 2.6...

> > On top of that, you can implement
> > CONFIG_NET_FASTROUTE in the driver, bypassing most
> of
> > the IP stack.
>
> But, of course, you'll loose IP tables. Also,

Yes, an important point.

-Brian


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
