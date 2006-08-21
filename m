Return-Path: <stefanr@s5r6.in-berlin.de>
Received: from hp3.statik.tu-cottbus.de (hp3.statik.TU-Cottbus.De
	[141.43.120.68]) by ozlabs.org (Postfix) with ESMTP id EB03067B7A
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 18:25:41 +1000 (EST)
Message-ID: <44E96719.6060003@s5r6.in-berlin.de>
Date: Mon, 21 Aug 2006 09:56:09 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
MIME-Version: 1.0
To: Wolfgang Pfeiffer <roto@gmx.net>
Subject: Re: Broken Firewire 400/SCSI on ppc Powerbook5,8
References: <20060817230347.GC3440@localhost> <20060818234930.GB2662@localhost>
	<44E6D634.3000207@s5r6.in-berlin.de>
	<20060820013121.GA2732@localhost>
In-Reply-To: <20060820013121.GA2732@localhost>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux1394-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Wolfgang Pfeiffer wrote:
[...]
> So at least it looks now as if the Firewire 400 Hardware on the
> alubook is not broken. Correct? Would be a great relief as I hate it
> to have it away at the repair service.
> 
> I could mount the 2 tibook partitions easily on the alubook.

Yes, the port is certainly working correctly.

> OTOH: Connecting the alubook and tibook with Linux up and running on
> both machines did not create a working (FW) connection between them ..

Of course they won't export SBP-2 targets then. But they should be
visible in Linux' sysfs or gscanbus or OS X' system profiler as external
nodes. It is also possible to establish an IPv4 connection over FireWire
between them, using eth1394 on Linux and OS X' network preferences panel.

[...]
> BTW: Do you know how to switch off verbose logging for the 1394
> drivers once they're compiled into the kernel, via some
> echo  "<some-value>" to /sys/*/* ?
> I didn't find any entry there until now for that purpose ...

It can only be configured at compile time.
-- 
Stefan Richter
-=====-=-==- =--- =-=-=
http://arcgraph.de/sr/
