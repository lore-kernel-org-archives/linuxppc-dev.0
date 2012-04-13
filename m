Return-Path: <robert.sciuk@exfo.com>
Received: from smtpinqc.exfo.com (smtpinqc.exfo.com [206.162.164.97])
 by ozlabs.org (Postfix) with ESMTP id D3E56B7006
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Apr 2012 06:42:59 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: P4080 target has 16G memory stability issues ...
Date: Fri, 13 Apr 2012 16:30:39 -0400
Message-ID: <2DD52030B5146141BEB762A11AE97C4C014C6777@SPQCEXC05.exfo.com>
From: "Robert Sciuk" <robert.sciuk@exfo.com>
To: <linuxppc-dev@lists.ozlabs.org>
Cc: u-boot-request@lists.denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear list(s),

Our P4080 target board is using 2 SODIMM's on each of 2 Controllers
(4x4G DDR3), and we are seeing some memory problems (linux panics) when
beating up large amounts of memory (just under the 16G), on multiple
threads (7 or 8 CPUs).

Our DDR3 configuration is derived from the SPD dump of U-Boot, and we
are using a version based upon the 2011.09 release of U-Boot.  Our
firmware memory test, limited as it is to 2G chunks, and a single CPU
shows no problem, it is only using a small test program under Linux and
using multiple cpu's that we see the problems, and we can reproduce the
problem at will, although reducing our memory speed via the RCW does
seem to ameliorate the problem somewhat.

Questions:

	- is anyone using a similar configuration?
	- is anyone aware of limitations in the U-Boot 2011.09R version
of the mpc8xxx/ddr/* code we need to be aware of?
	- any ideas?

We've been pounding our heads on this for a while now, and I'm just
wondering if we are covering old territory here.

Cheers,
Rob.

Robert Sciuk
Senior Designer, R&D.
905.738.3741 xt 22621
