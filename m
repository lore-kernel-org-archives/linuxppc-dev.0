Message-ID: <388E53BA.5DC43A02@erols.com>
Date: Tue, 25 Jan 2000 20:54:02 -0500
From: Nelson Abramson <pogtal@erols.com>
MIME-Version: 1.0
To: jingai@floatingpenguins.com
CC: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: Adaptec PowerDomain 29160N supported?
References: <200001260144.UAA27868@shell.faradic.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


jingai wrote:

> I'm ready to purchase an adaptec scsi card to replace my initio miles
> (doesn't work under linux/ppc), and I noticed that the 29160N is around the
> same price as the 2940UW... so, my question is, is it supported under
> LinuxPPC?  and what exactly makes it 160MB/s?  if anyone else owns this
> card, I'd like to hear your impressions..

Which initio card are you giving up on?  There are device drivers for two
types of initio cards last time I looked in the kernel config files (I have no
idea if they work, I've just seen them in existance).
    I don't know about that particular card, but AFAIK, the only scsi
standards capable of hitting 160mb/s are u2w lvd, which means that they have a
huge bandwith, and use extremely low amounts of energy  Only u2w lvd drives
can get anywhere near that amount of data transfer, and the chain is only as
fast as your slowest device, so if you are migrating a regular ole scsi narrow
drive onto a u2w lvd chain, it's only going to go at scsi narrow speeds, which
is about 10mb/s max.
    As a side comment, the state of scsi has gone down hill ever since Apple
stopped bundling one w/ every new mac...


HTH
--Nelson Abramson


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
