Date: Tue, 14 Jan 2003 22:57:05 +0530
From: Chirag Kantharia <kantharia@hathway.com>
To: Claus Gindhart <Claus.Gindhart@kontron.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Assistance with using /dev/fb0 and No X windows
Message-ID: <20030114225705.A1431@toxic>
Reply-To: Chirag Kantharia <kantharia@hathway.com>
References: <21A8AE56EBB6D411A4520060973D360101A9F739@PEPINTERCOM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <21A8AE56EBB6D411A4520060973D360101A9F739@PEPINTERCOM>; from Claus.Gindhart@kontron.com on Tue, Jan 14, 2003 at 08:46:56AM +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Jan 14, 2003 at 08:46:56AM +0100, Claus Gindhart wrote:
| Please remove console=ttyS0 from the kernel command line. Put a console=xxx
| command, which is appropriate for your framebuffer driver (see sourcecode
| of framebuffer driver)

That's incorrect. console=tty1 should do fine. CONFIG_VT and
CONFIG_VT_CONSOLE, as Claus said, are necessary.

--
Chirag Kantharia, symonds.net/~chyrag/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
