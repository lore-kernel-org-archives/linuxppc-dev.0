Date: Tue, 4 Jan 2000 22:24:21 -0700
From: Cort Dougan <cort@fsmlabs.com>
To: Alois Fertl <alois_fertl@talknet.de>
Cc: LinuxppcDev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Changes for IDE on PREP Hardware
Message-ID: <20000104222421.A31468@hq.fsmlabs.com>
References: <38710186.B7930E52@talknet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <38710186.B7930E52@talknet.de>; from Alois Fertl on Mon, Jan 03, 2000 at 09:07:34PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


} Attached is a patch which allows to work Motorola PREP hardware (like
} Blackhawk) to use IDE devices (disk and cdrom). The patch tries to
} selectively introduce the changes for the Motorola hardware only.
} IBM's can stay with their irq 13 for IDE and with their preferred
} method of non swapped data stream. I have no chance to test on IBM.

How would this work if both irqs arrive at the same time?

Johnnie, Matt - can you test this out on your systems?

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
