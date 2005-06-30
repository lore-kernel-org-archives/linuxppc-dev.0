Return-Path: <ronb@lcsaudio.com>
Received: from lcsaudio.com (lcsaudio.com [66.160.193.223])
	by ozlabs.org (Postfix) with SMTP id B37E067B94
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Jul 2005 07:37:54 +1000 (EST)
Received: from ronsp4 ([24.70.124.240]) by lcsaudio.com for
	<linuxppc-embedded@ozlabs.org>; Thu, 30 Jun 2005 14:28:19 -0700
From: "Ron Bianco" <ronb@lcsaudio.com>
To: "Linuxppc-Embedded" <linuxppc-embedded@ozlabs.org>
Date: Thu, 30 Jun 2005 14:29:47 -0700
Message-ID: <NCBBJPCHJLKAEAHINDCEIEMOFPAA.ronb@lcsaudio.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Cc: cort@cs.nmt.edu
Subject: ppc_htab.c and ppc7447A performance monitor registers
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

( referring to kernel source as of 2.6.11 )

Among other things, Cort Dougan has provided support for usage of the
performance counters in 604 type cores via: /proc/ppc_htab.
This is great, but the required cpu feature: CPU_FTR_604_PERF_MON is not in
the list for the 7447 ppc family.

I guess there are differences related to the performance counter registers
and the monitor control registers between the the 604 core types and 7447,
but I haven't had time to research it.

I was wondering if anyone has upgraded:  cputable.c and ppc_htab.c for use
with ppc types, other than 604, that have performance monitor registers and
if such code is publically available?

regards, Ron
