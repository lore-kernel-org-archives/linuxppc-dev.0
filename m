In-Reply-To: <Pine.LNX.4.05.10002081749540.27293-100000@callisto.of.borg>
Date: Tue, 8 Feb 2000 22:30:45 +0100
To: Geert Uytterhoeven <geert@linux-m68k.org>, linuxppc-dev@lists.linuxppc.org,
        linux-fbdev@vuser.vu.union.edu
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: [linux-fbdev] Retrace
Message-Id: <20000208223045.004499@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Feb 8, 2000, Geert Uytterhoeven <geert@linux-m68k.org> wrote:

>The BAR values in PCI config space may be the same, but the BAR values in
>struct pci_dev can be made different by the machine-specific fixup code.

This would work as long as no one reads the BAR directly. I know no-one
should do it, but I've seen some time ago (can't remember where) some
drivers reading BARs directly. Also, I don't know for the X server.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
