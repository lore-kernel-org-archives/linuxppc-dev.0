From: Christophe.LINDHEIMER@fr.thalesgroup.com
Message-ID: <D96E2AFA0DF3D211B139009027454948034CBE2D@helios.gnv.tcc.thomson-csf.com>
To: chris@cryptoapps.com, Christophe.LINDHEIMER@fr.thalesgroup.com
Cc: zjzhou@newrocktech.com, linuxppc-embedded@lists.linuxppc.org
Subject: RE: [Linux] Problem with booting Linux
Date: Thu, 19 Jun 2003 16:29:49 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > In Bdi, if I make
> > 	reset run
> > 	go
> > Then in Uboot
> > 	bootm 0x43000000
> > Linux hangs when trying to start init.
>
> What does the board do without the BDI attached?

If the BDI is not attached, it works !!!
Must admit that I hadn't try this config.
Thanks.

> More interesting yet,
> have you stopped the kernel to see where it's hung?

When the kernel hung, the 860 doesn't respond anymore and BDI just timeout
on the halt command :((

Chris

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
