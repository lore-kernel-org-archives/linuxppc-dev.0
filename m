Message-Id: <4.3.2.7.2.20000803122831.0356a2a0@mail.munich.netsurf.de>
Date: Thu, 03 Aug 2000 12:31:16 +0200
To: Martin Costabel <costabel@wanadoo.fr>
From: Franz Sirl <Franz.Sirl@munich.netsurf.de>
Subject: Re: rtc again...
Cc: linuxppc-dev@lists.linuxppc.org, Iain Sandoe <iain@sandoe.co.uk>
In-Reply-To: <398934C7.663E6BD9@wanadoo.fr>
References: <200008022249.XAA32651@hyperion.valhalla.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 11:00 03.08.00, Martin Costabel wrote:
>Iain Sandoe wrote:
> >
> > Hi,
> >
> > under 2.2.17pre15ben1
> >
> > rtc does not give me the right answer when built in - what am I doing
> wrong?
> >
> > It won't build load as a module right now 'cos I forgot to check ppc_ksyms
> > before doing the build :-( .... (I remembered for 2.4.0).
> >
> > under 2.4.0-test5 it seems to be fine as a module (haven't tried built in).
>
>I am using it as module both for 2.2.17-bk and for 2.4.0-test5. They
>don't give the same time, and I think it is the one in 2.4.0 that is
>right. I am at GMT+2:00, and the time in 2.2.17 is 2 hours early. When I
>change /etc/sysconfig/clock from "UTC=false" to "UTC=true", both times
>shift by 2 hours, but the discrepancy remains.

Are you sure you are using the "hwclock" utility coming with util-linux?
And not the old pmac specific "clock" utility to query the clock? What
happens if you remove all "clock" binaries from your system?

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
