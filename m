Message-Id: <4.3.2.7.2.20000714210226.039b37f0@mail.munich.netsurf.de>
Date: Fri, 14 Jul 2000 21:06:44 +0200
To: Martin Costabel <costabel@wanadoo.fr>
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: Upgraded utils...
Cc: Iain Sandoe <iain@sandoe.co.uk>, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <396F61D7.FCBCCB22@wanadoo.fr>
References: <200007141730.SAA17219@hyperion.valhalla.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 20:54 14.07.00, Martin Costabel wrote:
>Could be /sbin/hwclock is now a binary that was compiled with
>util-linux. This doesn't mean it works, though. Better put the old fake
>hwclock shell script there ("/sbin/clock -s"). Or is one now supposed to
>create /dev/rtc and use it as on any other architecture?

Yes! That's why I did CONFIG_PPC_RTC, it's such simple code, but it helps a
lot to bring us in line with the other architectures.

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
