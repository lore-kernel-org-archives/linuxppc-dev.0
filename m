Message-ID: <396F6725.417473B@wanadoo.fr>
Date: Fri, 14 Jul 2000 21:16:53 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
CC: Iain Sandoe <iain@sandoe.co.uk>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Upgraded utils...
References: <200007141730.SAA17219@hyperion.valhalla.net> <4.3.2.7.2.20000714210226.039b37f0@mail.munich.netsurf.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Franz Sirl wrote:
>
> At 20:54 14.07.00, Martin Costabel wrote:
> >Could be /sbin/hwclock is now a binary that was compiled with
> >util-linux. This doesn't mean it works, though. Better put the old fake
> >hwclock shell script there ("/sbin/clock -s"). Or is one now supposed to
> >create /dev/rtc and use it as on any other architecture?
>
> Yes! That's why I did CONFIG_PPC_RTC, it's such simple code, but it helps a
> lot to bring us in line with the other architectures.

Yes, sorry I forgot, I have actually already used this, back in the good
old days when I could still boot 2.4.0-testX. But does this actually
work with the hwclock program from standard RedHat util-linux?

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
