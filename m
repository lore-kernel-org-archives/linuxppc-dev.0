From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>
Subject: Re: aty128fb does not work in newer sawtooth machines
Date: Sun, 12 Mar 2000 12:25:43 -0500
Content-Type: text/plain
References: <00031112260400.11535@localhost.localdomain> <20000313014927K.roikawa@rr.iij4u.or.jp>
In-Reply-To: <20000313014927K.roikawa@rr.iij4u.or.jp>
Cc: brad@turbolinux.com, linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Message-Id: <00031212301701.00484@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Ryuichi,

> > I am going to add this card to the Xpmac source so that it tries to use its
> > acceleration code simply on the straight OF frame buffer.  If that works, then
> > I should be able to use Xpmac to get some of timing info.

>  Yes, Xpmac should run by simply adding 'PF' to the probe list, but you don't
> need to run Xpmac since MacOS(and OF?) adds clock timing field to device-tree
> like as,
>
> /proc/device-tree/pci/ATY,Rage128y:
> name             "ATY,Rage128y"
> vendor-id        00001002 (4098)
> device-id        00005245 (21061)
> ...............................
> RRF,XCLK          00001d4d (7501)
> RF,MCLK          00001d4d (7501)
> RF,VCLK          000059a6 (22950)
> RF,REF           00000b86 (2950)
> ...............................

If I boot my G4 in OF and use lsprop to dump the of-device tree, unfortunately,
none of the nice RF properties are there.  So these properties must have been
added by MacOS but do not get written when yaboot is used to boot the machine.
Unfortunately, I can't use BootX to boot the newer sawtooths.

That means I will have to read these values from the MacOS side of things.  Ben
H pointed me to the PCI DDK utility that dumps the device registry under MacOS
and I will give that a try tomorrow when I am at work.

> PS. Please don't forget to build the (a)-(c) for Robert.

Yes, I will build that this evening after my kids go to bed and I will post it
for Robert first thing tomorrow.

Take care,

Kevin


--
Kevin B. Hendricks
Associate Professor of Operations and Information Technology
Richard Ivey School of Business, University of Western Ontario
London, Ontario  N6A-3K7  CANADA
khendricks@ivey.uwo.ca, (519) 661-3874, fax: 519-661-3959


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
