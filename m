Date: Thu, 1 Nov 2001 16:53:33 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: APUS irq patch
Message-ID: <20011101165333.A26680@cpe-24-221-152-185.az.sprintbbd.net>
References: <Pine.LNX.4.33.0111020007080.8971-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.33.0111020007080.8971-100000@serv>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Nov 02, 2001 at 12:18:34AM +0100, Roman Zippel wrote:

> This patch converts the irq assembly in head.S into C, the only problem is
> that I needed to change a prototype in <linux/irq.h>, as some additional
> info has to be saved/restored during an irq.

Ack.  Won't this break other things?  I'm assuming other arches use
-end() too..

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
