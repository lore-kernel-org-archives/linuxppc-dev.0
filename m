Date: Sat, 8 Jul 2000 16:29:15 -0700
From: Matt Porter <mmporter@home.com>
To: Michael Lundkvist <ml@epact.se>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Going from 2.2.12 to 2.2.17pre10
Message-ID: <20000708162915.A11060@cx258813-a.chnd1.az.home.com>
References: <Pine.HPX.4.10.10007061912350.21326-100000@gra-ux1.iram.es> <qp66qji2pq.fsf@erbium.epact.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <qp66qji2pq.fsf@erbium.epact.se>; from ml@epact.se on Thu, Jul 06, 2000 at 07:32:49PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jul 06, 2000 at 07:32:49PM +0200, Michael Lundkvist wrote:
>
> Gabriel Paubert <paubert@iram.es> writes:
> > Under 2.2.12 dd if=/dev/hda of=xxx bs=512 count=1 and see what comes out.
> > Can PPCBUG actually boot from these disks ?

PPCBUG expects a little endian partition table, so no.

> Nope. I think I'll go for Bugboot. Ramix also talked about the
> possibility of modifying PPCBug to add support for the Ramix 233.

I really have to recommend against that.  Once Ramix sees the icky PPCBUG
code they will hate as much as I do.  I gave well documented changes to
the PPCBUG guys so that BUGBOOT wasn't needed to boot a kernel from
FLASH on a PowerPlus board but they haven't incorporated those changes
after a full year now. :)

--
Matt Porter
mmporter@home.com
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
