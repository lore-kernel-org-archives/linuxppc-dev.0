Mime-Version: 1.0
Message-Id: <v04220800b50626da1488@[10.0.0.42]>
In-Reply-To: <200003271909.VAA01187@piglet.grunz.lu>
References: <200003271909.VAA01187@piglet.grunz.lu>
Date: Tue, 28 Mar 2000 01:34:16 -0800
To: mlan@cpu.lu, toa@pop.agri.ch
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: pci-resources feedback
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 9:09 PM +0200 3/27/00, Michel Lanners wrote:

>>  ---2399-dmesg---
>>  PCI: Probing PCI hardware (semiautomatic)
>>  Scanning bus 00
>>  Found 00:00 [1057/0002] 000600 00
>>  Found 00:68 [106b/0010] 00ff00 00
>>  Found 00:80 [106b/0010] 00ff00 00
>
>Hmmm... two times the same dev?? You really have two heathrows?

The "Wall Street" and "PDQ" series PB G3s really do have two heathrow
ASICs.  One of them is the main Heathrow.  The other is only present
because these two PB models need three IDE channels and three serial
channels, and a single Heathrow provides just two of each.  (Two IDEs
for the two expansion bays, one IDE for the internal HD, one serial
for IrDA, one serial for the internal modem, and one serial for the
general purpose serial port.)

   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
