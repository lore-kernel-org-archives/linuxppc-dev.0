From: Benjamin Herrenschmidt <bh40@calva.net>
To: Takashi Oe <toe@unlserve.unl.edu>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4.0-test3
Date: Tue, 11 Jul 2000 00:14:10 +0200
Message-Id: <20000710221410.2067@192.168.1.10>
In-Reply-To: 
 <Pine.LNX.3.96LJ1.1b7.1000710164335.14195C-100000@ofey.inetnebr.com>
References: 
 <Pine.LNX.3.96LJ1.1b7.1000710164335.14195C-100000@ofey.inetnebr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Why is pmac_backlight.c compiled in for CONFIG_ALL_PPC?  Isn't it
>PowerBook only thing?

Well, if you change that, then chipsfb.c, atyfb.c, aty128fb.c and via-
pmu.c must be changed too. It's not completely powerbook only since, at
term, this could driver also external LVDS LCD backlight.

>> Well, you can check disabling that (and the call that sets up this BAT in
>> head.S) but don't forget, if you do that, to also declare
>> bootx_text_mapped to 0 before leaving prom.c
>
>601's BAT doesn't have G bit.  Maybe that's the problem?

Maybe. I'll push a change without it and see


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
