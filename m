Date: Mon, 26 Jun 2000 13:11:53 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Michel Lanners <mlan@cpu.lu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ide_delay_50ms() freezing on PPC?
In-Reply-To: <200006262005.WAA00763@piglet.grunz.lu>
Message-ID: <Pine.LNX.4.10.10006261310470.27975-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 26 Jun 2000, Michel Lanners wrote:

> Hi Andre,
>
> On  25 Jun, this message from Andre Hedrick echoed through cyberspace:
> > Then we need braoder stubs.
> > Got a suggestion?
>
> No... before suggesting anything, I'd like to understand why the loop
> doesn't work on PPC (only on PPC?), and why the use of
> schedule_timeout() depends on PCMCIA ide devices....

The PCMICA requested a scheduler, but new code that I am creating for a
Cascade Project requires the loop.

Andre Hedrick
The Linux ATA/IDE guy


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
