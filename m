Date: Sat, 20 Jan 2001 14:15:06 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Michel Dänzer <michdaen@iiic.ethz.ch>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jeff Hartmann <jhartmann@valinux.com>,
        Gareth Hughes <gareth@valinux.com>, <linuxppc-dev@lists.linuxppc.org>,
        <dri-devel@lists.sourceforge.net>
Subject: Re: [Dri-devel] PPC Lockup (ati-pcigart-branch)
In-Reply-To: <3A68FC06.7BEEA13D@iiic.ethz.ch>
Message-ID: <Pine.LNX.4.30.0101201414160.18939-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Additionally, on PPCs, you have another technique, which is to use
> > prom_print or xmon_printf() (the latest one support full printf semantics
> > while the first one only supports a simple string).
>
> xmon might really be helpful, but the crash is after the X server blanks the
> display, so I wonder if xmon output would be visible?

IIRC xmon output did show up on the serial console (similar X related
debugging last year on the Lombard).

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
