Date: Wed, 26 Sep 2001 00:24:38 -0400 (EDT)
From: "Peter R. Wood" <prwlists@cephas.dyndns.org>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: pci probs with recent linuxppc_2_4_devel kernel
Message-ID: <Pine.LNX.4.33L2.0109260016160.20753-100000@woburn.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

I've been having some problems with recent linuxppc_2_4_devel kernels.
Specifically, my PCI bus and devices don't seem to be recognized properly.
I have a SuperMac J700, with a 3c905 ethernet card and an ati rage 128
video card.. neither of them seems to be recognized:

Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Cannot allocate resource region 0 of device 00:0d.0
PCI: Cannot allocate resource region 2 of device 00:0d.0
PCI: Cannot allocate resource region 0 of device 00:10.0
etc...

Is there a patch available to fix this? Right now I am using an older
kernel, since the kernel in its current state doesn't enable my video or
ethernet cards.

Thanks,

Peter

--
Peter R. Wood - prwlists@cephas.dyndns.org - http://cephas.dyndns.org/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
