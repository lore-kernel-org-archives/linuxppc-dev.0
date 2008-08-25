Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [204.133.123.27])
	by ozlabs.org (Postfix) with ESMTP id 2FC21DE972
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Aug 2008 01:43:40 +1000 (EST)
Message-ID: <48B2D167.40008@mlbassoc.com>
Date: Mon, 25 Aug 2008 09:36:07 -0600
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: MPC5200 FEC problems
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm adding the Analogue & Micro Boa (MPC5200/B) platform to the
public 2.6.26 tree.  Under heavy network load (sometimes even
not so heavy!), I get this error:
   net eth0: FEC_IEVENT_RFIFO_ERROR
I've read the thread about how this leads to an incorrect call
to the PHY code in the ISR.  It's good to know that part of the
problem is being worked on.

My question is - what exactly does this error imply?  Looking at
the MPC5200 manual doesn't give much info - just that there was
a Rx FIFO error.

I'm also perplexed by the fact that I have two slightly different
Boa boards (same CPU rev, speed, etc).  About the only thing that's
different is the SDRAM setup.  One board is rock solid while the
other gets this error almost immediately.

Also, I sometimes get a Tx timeout on this platform (the one that
fails as above).
   net eth0: transmit timed out
Note that I don't have any trouble with this platform running RedBoot
or eCos, just Linux :-(

Here's the basic info on my platform:

root@ppc_target:~ cat /proc/cpuinfo
processor       : 0
cpu             : G2_LE
clock           : 396.000000MHz
revision        : 1.4 (pvr 8082 2014)
bogomips        : 49.40
timebase        : 24750000

Ideas?  Any help graciously accepted.

n.b. I'm not currently subscribed to this list, so please CC
me on any replies.

Thanks

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
