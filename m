Content-Type: text/plain;
  charset="iso-8859-1"
From: David Given <dg@tao-group.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: iMac / ATI Rage 128 Pro TR
Date: Fri, 14 Dec 2001 14:26:36 +0000
References: <E16Erwf-0000bT-00@rhodium.tao.co.uk> <20011214132648.25744@smtp.adsl.oleane.com>
In-Reply-To: <20011214132648.25744@smtp.adsl.oleane.com>
MIME-Version: 1.0
Message-Id: <E16EtIK-0001kb-00@rhodium.tao.co.uk>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Friday 14 December 2001 13:26, Benjamin Herrenschmidt wrote:
[...]
> >Unfortunately, it uses a rather odd video card, a Rage Pro TR (id
> > 1002.5452). The kernel does not support this, so I'm stuck with the Open
> > Firmware driver at 800x600x8. I've tried modifying the kernel so that
> > it's treated as any other Rage Pro, but the kernel seg faults.
[...]
> Are you sure this isn't a Rage 128 Pro ? It's driven by aty128fb

It is a Rage 128 Pro, but a variant that aty128fb doesn't know about; the PCI
ID isn't even defined in the kernel. I tried adding it but it didn't work, so
presumably it's doing something rather different to the ordinary Rage 128
Pros.

--
David Given
dg@tao-group.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
