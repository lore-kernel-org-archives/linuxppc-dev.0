Message-ID: <39C78056.EF7C45A9@mpifr-bonn.mpg.de>
Date: Tue, 19 Sep 2000 17:03:50 +0200
From: Albrecht Dre_ <ad@mpifr-bonn.mpg.de>
MIME-Version: 1.0
To: LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>
Subject: PCMCIA card eject does not work?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am currently playing with PCMCIA/Cardbus stuff on several machines. On the
Wallstreet, there is no "manual" way to eject a card (except with a paper clip).
I added a patch by Harald Roelle to the pcmcia package which talks to the pmu to
do this (see http://www.roelle.com/wvlanPPC/data/pcmcia-3.1.17-pmac.patch).
Although the software talks to the PMU (I added a few debug lines to via_pmu.c),
the card is _not_ ejected. Were there any recent changes in the pmu stuff? I use
Ben's latest stable test kernel (2.2.17pre20-ben3). Any ideas how I could track
down the problem?

BTW, do the Lombard and Pismo support automatic ejection of CardBus cards? This
would be _really_ cool...

Thanks in advance, Albrecht.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
