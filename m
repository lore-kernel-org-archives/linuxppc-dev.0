Date: Wed, 10 Apr 2002 14:29:53 +0200
From: Uwe Steinmann <Uwe.Steinmann@FernUni-Hagen.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: dsp block size of dmasound?
Message-ID: <20020410142953.A20650@gehtnix.fernuni-hagen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I just compiled linphone for linux ppc on a 2.4.18 benh kernel succesfully,
and was able to connect to a second linphone on another computer, though
there has been no voice transmission. After a small discussion with the
developer of linphone he wondered about the high latency of the sound card.

> > Warning: dsp block size set to 16384.
> OUCH !! 16386 bytes is very very high latency ! Your sound card is
> perhaps very old, or the driver is not very performant !
> I've never see that. The most I had was 8192.
> Recent PCI cards give 512 bytes.

This was done on a Pismo.
I wonder if the block size is normal for a Pismo or if this could be the
reason for the lack of voice transmission.

   Uwe
--
  MMK GmbH, Hagen
  Uwe.Steinmann@mmk-hagen.de
  Tel: +2331 987 4528    Fax: +2331 987 375

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
