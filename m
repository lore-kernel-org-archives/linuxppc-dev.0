Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 82EEA67A64
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Feb 2005 02:51:03 +1100 (EST)
Received: from linux.local (linux.prtnl [192.168.1.97])
	by protonic.prtnl (Postfix) with ESMTP id EFD7052DD
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Feb 2005 16:51:00 +0100 (CET)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Date: Thu, 17 Feb 2005 16:50:53 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200502171650.53799.david.jander@protonic.nl>
Subject: Which kernel tree for future 8xx development?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi,

Which (of the many) is the most recommended 2.4.x tree for mpc8xx devices 
(specially the MPC852T). We are developing our own board-support stuff and 
drivers (it's a custom board designed by us).
Currently we have linuxppc-2_4_devel from DENX cvs and linuxppc-2_4_devel from 
bitkeeper, which seems to be a newer kernel version, but with much less 
different boards supported and less features for motorola powerpc processors. 
What's the status of CPM driver stuff for instance?

We started on DENX kernel sources and switched to bitkeeper because of some 
misinterpreted advice I received from this list about an unrelated problem, 
only to find apparently less mpc8xx support.

Now I am observing myself doing apparently absurd things as for example taking 
arch/ppc/8260_io/cpm_spi.c from DENX and putting it into arch/ppc/8xx_io/ 
from bitkeeper and hacking until it works (again). It still doesn't. Where on 
earth is the original driver (which was for MPC860, not MPC8260)!??

Before we port all of our stuff once again from one tree to another, can 
someone please give me a good advice on which way to go now and in forseeable 
future? 
One day I'd like to be able to make all our board-support stuff into something 
useful for others and go beg for inclusion in the main sources.... but where?

Greetings,

-- 
David Jander
Protonic Holland.
