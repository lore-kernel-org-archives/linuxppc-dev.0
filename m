From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15042.55896.10936.34707@pizda.ninka.net>
Date: Wed, 28 Mar 2001 22:46:48 -0800 (PST)
To: Daniel Berlin <dan@www.cgsoftware.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: ieee1394 fixed soon...
In-Reply-To: <Pine.LNX.4.10.10103290139551.18522-100000@www.cgsoftware.com>
References: <Pine.LNX.4.05.10103290815070.11053-120000@callisto.of.borg>
	<Pine.LNX.4.10.10103290139551.18522-100000@www.cgsoftware.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Daniel Berlin writes:
 > Dave, I already took care of most of these. If you remove the selfid
 > bitfields, the set of patches i sent to the linux1394 list recently to
 > make it work on a powerbook g3 should work fine on other big-endian
 > architectures.

Thanks, I was not aware of these patches, I'll check them out.

 > I also have a set of endian fixes for the sbp-2 driver that james goodwin
 > (author of the sbp-2 stuff) is working on integrating, mainly it involves
 > removal of all of the bitfields, which were screwing up non-LE
 > architectures.
 >
 > I happily use my two 45 gig firewire drives under LinuxPPC, and have been
 > for weeks.

It won't work on sparc64 until it is fixed to not use
virt_to_bus/bus_to_virt and uses the PCI dma interfaces instead.
I have one of these drives as well :-)

The video1394 driver needs the same kind of work.

Later,
David S. Miller
davem@redhat.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
