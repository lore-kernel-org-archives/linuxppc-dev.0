Message-ID: <38EB6A36.1A8D24C1@erols.com>
Date: Wed, 05 Apr 2000 12:30:46 -0400
From: Nelson Abramson <pogtal@erols.com>
MIME-Version: 1.0
To: haffner@astro.wisc.edu
CC: Linux Dev List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: XFree 4 & sound problems
References: <38EAD4E8.61CD5BCA@astro.wisc.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Matt Haffner wrote:

> If I just let things go and don't touch anything, it plays fine. The
> freeze requires a reset button reboot--the machine is not reachable at
> all (i.e. it's not just X).

Could you maybe check what parameters you have enabled on your disk via
hdparm?  I have had a few hard freezes, and I think they are related to a
small bug in either multiword dma or irq masking.  If I have those options
enabled, I occasionally get a machine freeze, caused by xmms (once by
slocate via cron)...(that's what the xmon debugger says anyways)

--Nelson Abramson

--
Shouldn't people be arrested and persecuted for engaging in their
constitutional rights?  http://www.opendvd.org


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
