To: linuxppc-dev@lists.linuxppc.org
Subject: Re: PCMCIA card eject does not work?
In-Reply-To: <39C78056.EF7C45A9@mpifr-bonn.mpg.de>
References: <39C78056.EF7C45A9@mpifr-bonn.mpg.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <20000920174030P.tkoba@ike-dyn.ritsumei.ac.jp>
Date: Wed, 20 Sep 2000 17:40:30 +0900
From: "T.R. Kobayashi" <tkoba@ike-dyn.ritsumei.ac.jp>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I am currently playing with PCMCIA/Cardbus stuff on several machines. On the
> Wallstreet, there is no "manual" way to eject a card (except with a paper clip).
> I added a patch by Harald Roelle to the pcmcia package which talks to the pmu to
> do this (see http://www.roelle.com/wvlanPPC/data/pcmcia-3.1.17-pmac.patch).
> Although the software talks to the PMU (I added a few debug lines to via_pmu.c),
> the card is _not_ ejected. Were there any recent changes in the pmu stuff? I use
> Ben's latest stable test kernel (2.2.17pre20-ben3). Any ideas how I could track
> down the problem?

Harald Roelle's pcmcia-3.1.17-pmac.patch does not work well on my PB2400c.
I fixed this problem and wrote usb_cb.c for CardBus USB OHCI cards.
These functions may be available, as you use following sources.

http://www.ike-dyn.ritsumei.ac.jp/~tkoba/linuxppc/patches/2.2.18pre4-pb-mol-usb.diff
against Ben's kernel
http://kernel.xorsis.com/source/linux-pmac-benh.tar.gz (Sep. 12 2000)

http://www.ike-dyn.ritsumei.ac.jp/~tkoba/linuxppc/patches/pcmcia-cs-3.1.20-usb-pmac.tar.bz2

==============
T. R. Kobayashi


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
