From: Thomas Graichen <news-innominate.list.linux.ppc.dev@innominate.de>
Reply-To: Thomas Graichen <graichen@innominate.de>
Subject: IDE-DMA check
Date: 27 Aug 2000 08:12:37 GMT
Message-ID: <news2mail-8oaihl$tra$1@mate.bln.innominate.de>
Reply-To: thomas.graichen@innominate.de
To: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


i always get the following on the 2.4.0-test kernels:

ide0 at 0xcd8e7000-0xcd8e7007,0xcd8e7160 on irq 19
IDE-DMA check !
hda: 13379310 sectors (6850 MB) w/418KiB Cache, CHS=14158/15/63
IDE-DMA check !
hdb: ATAPI 24X CD-ROM drive, 128kB Cache

and it does not automatically set ide-dma although i enabled the
auto dma setting in the kernel config - what exactly does this
mean?

a lot of thanks in advance

t

--
thomas.graichen@innominate.de
technical director                                       innominate AG
clustering & security                                networking people
tel: +49.30.308806-13  fax: -77                   http://innominate.de

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
