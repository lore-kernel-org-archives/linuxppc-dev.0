Message-ID: <5725AF6EE9FAD51195DC009027E377020B6562DD@az33exm35.corp.mot.com>
From: Milliorn Gary-rxcr80 <Gary.Milliorn@motorola.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: TLB and CSSBAR problems with MPC8540 and BDI2000
Date: Wed, 14 Jan 2004 10:19:17 -0700
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Dan
> Malek
>
> Yep.  I have one now.  Make sure your u-boot image also has a TLB1
> entry for your "default" CCSRBAR.  Further, make sure your BDI init
> section doesn't move the CCSRBAR from the default value assumed by
> your u-boot image.  I had the latter correct, just didn't realize
> that a "TLB1 flash invalidate" command to the MMUCSR0 doesn't seem
> to honor the 'invalidate protect' in the TLB entry.  Everything
> works fine when you get all of the ducks in a row :-)

  The TLB1 issue is due to the MPC85x0 errata "CPU4"; there's a s/w
workaround.  It's nice if BDI fixes it for you, but seems like it would
not be necessary.

Gary Milliorn

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
