Message-ID: <39CB407E.DF3494EF@mpifr-bonn.mpg.de>
Date: Fri, 22 Sep 2000 13:20:30 +0200
From: Albrecht Dre_ <ad@mpifr-bonn.mpg.de>
MIME-Version: 1.0
To: "T.R. Kobayashi" <tkoba@ike-dyn.ritsumei.ac.jp>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: PCMCIA card eject does not work?
References: <39C78056.EF7C45A9@mpifr-bonn.mpg.de> <20000920174030P.tkoba@ike-dyn.ritsumei.ac.jp>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"T.R. Kobayashi" wrote:
> Harald Roelle's pcmcia-3.1.17-pmac.patch does not work well on my PB2400c.
> I fixed this problem and wrote usb_cb.c for CardBus USB OHCI cards.
> These functions may be available, as you use following sources.
>
> http://www.ike-dyn.ritsumei.ac.jp/~tkoba/linuxppc/patches/2.2.18pre4-pb-mol-usb.diff
> against Ben's kernel
> http://kernel.xorsis.com/source/linux-pmac-benh.tar.gz (Sep. 12 2000)
>
> http://www.ike-dyn.ritsumei.ac.jp/~tkoba/linuxppc/patches/pcmcia-cs-3.1.20-usb-pmac.tar.bz2

Thanks for your links... Your patches do indeed eject a CardBus card on my
Wallstreet. Great! However, I think the mechanics is a little problematic on
this box, as the card sometimes seems to have contact to the connector after the
eject. This leads to an immediate re-recognition of the card, and as the contact
is everything but perfect, I get a panic. Maybe I try to file more than one
eject command to the PMU and see what happens...

Thanks again, Albrecht.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
