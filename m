Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 28D91DE021
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 09:39:38 +1100 (EST)
Received: from lyakh (helo=localhost)
	by poirot.grange with local-esmtp (Exim 3.36 #1 (Debian))
	id 1HADFo-0003aO-00
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 23:39:36 +0100
Date: Thu, 25 Jan 2007 23:39:36 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: linuxppc-dev@ozlabs.org
Subject: 82xx CPU features
Message-ID: <Pine.LNX.4.60.0701252333210.13557@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all

wandering around the idle code, noticed the following:

#define CPU_FTRS_603	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | \
	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_PPC_LE)

...

#define CPU_FTRS_82XX	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB)

Whereas even in

static struct cpu_spec cpu_specs[] = {
...
	{	/* 82xx (8240, 8245, 8260 are all 603e cores) */
...

So, wanted to ask - is there a specific reason why CPU_FTR_MAYBE_CAN_NAP 
is not set for 82xx (as well as CPU_FTR_PPC_LE for that matter...)

Thanks
Guennadi
---
Guennadi Liakhovetski
