Message-ID: <3AFE3C09.835966B5@folkwang-hochschule.de>
Date: Sun, 13 May 2001 09:47:21 +0200
From: =?iso-8859-1?Q?J=F6rn?= Nettingsmeier <nettings@folkwang-hochschule.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: pismo sleep behaviour w/ 2.4.4-benh
References: <3AFD9868.29C558@folkwang-hochschule.de> <20010512203422.23549@smtp.wanadoo.fr>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
>
> >
> >* the box usually falls asleep again after waking up. when woken
> >again, it stays up like it should.
>
> Never seen that. How do you trigger sleep ?

either by closing the lid, by not doing anything for a while or by
using the "snooze" program that comes with pmud.

> >* every 10 or so sleep cycles, the machine locks up. blank screen,
> >no standby-led, and i can only power off with ctrl-alt-apple-power.
> >sysrq fails, too.
>
> It locks up on wakeup or on sleep ?

well, it looks like it's going to sleep, but the standby led doesn't
blink. just like when i switch it off, except i can't switch it on
again by simply pressing "power", so i suspect it hangs.


> >* the box falls asleep sometimes even when i'm busy typing or moving
> >the mouse. this happens at least once every half hour.
>
> What do you mean by "fall asleep" ? it stops working ? how do you
> get it back ?

it enters sleep mode, even though there are pretty many keyboard and
mouse events that should keep it from doing so.
i get it back by pressing a key after waiting a few seconds.
(immediately after entering sleep mode, key events seem to be
ignored for a few seconds.)




--
Jörn Nettingsmeier
home://Kurfürstenstr.49.45138.Essen.Germany
phone://+49.201.491621
http://icem-www.folkwang-hochschule.de/~nettings/
http://www.linuxdj.com/audio/lad/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
