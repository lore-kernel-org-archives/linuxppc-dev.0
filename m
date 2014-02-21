Return-Path: <schivers@csc.com.au>
Received: from mail1.bemta12.messagelabs.com (mail1.bemta12.messagelabs.com
 [216.82.251.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2239A2C0334
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Feb 2014 11:30:52 +1100 (EST)
Received: from amer-gw15.amer.csc.com (amer-gw15.amer.csc.com [20.137.2.189])
 by amer-mta113.csc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
 ESMTP id s1L0UXl0021774
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Feb 2014 19:30:34 -0500
In-Reply-To: <mailman.2751.1392850114.4571.linuxppc-dev@lists.ozlabs.org>
References: <mailman.2751.1392850114.4571.linuxppc-dev@lists.ozlabs.org>
To: linuxppc-dev@lists.ozlabs.org
MIME-Version: 1.0
Subject: GDB diagnostic for System-supplied DSO.
From: Stephen N Chivers <schivers@csc.com.au>
Message-ID: <OFC31EE98F.58567D74-ONCA257C86.00018E2B-CA257C86.0002CBF9@csc.com>
Date: Fri, 21 Feb 2014 10:30:32 +1000
Content-Type: text/plain; charset="US-ASCII"
Cc: Chris Proctor <cproctor@csc.com.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Using GDB to "debug" a trivial PowerPC test program using a kernel derived 
from
yesterdays Linux-next I get:

        "Can't read symbols from system-supplied DSO at 0x100000: File 
truncated"

when the program is run.

There is no apparent ill effect from this.

It happens for both natively and cross compiled programs.

Stephen Chivers,
CSC Australia Pty. Ltd.
