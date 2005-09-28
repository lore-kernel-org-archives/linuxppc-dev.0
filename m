Return-Path: <gguevel@interfaceconcept.com>
Received: from smtp4.clb.oleane.net (smtp4.clb.oleane.net [213.56.31.20])
	by ozlabs.org (Postfix) with ESMTP id 8F49868416
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Sep 2005 17:59:59 +1000 (EST)
From: =?iso-8859-1?Q?G=E9rard_Gu=E9vel?= <gguevel@interfaceconcept.com>
To: "'Andy Fleming'" <afleming@freescale.com>
Date: Wed, 28 Sep 2005 10:02:18 +0200
Message-ID: <003201c5c402$fb80d430$5201a8c0@GEG2400>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <B310BDDC-A773-4D85-8314-F4320C5FA90C@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: How to use SPE on MPC8541
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Andy,

> Your driver runs in kernel space.  The kernel has the SPE bit off.
> The MSR state is process-specific.  If the code executes, the
> MSR bit
> is set.  Why do you want to see if the bit is set?

OK, this is a bad idea to use a driver to check the msr register.

I don't especially want to see if the bit is set, I just want
to improve the board performance for a Linux application :-).

To check the performance, I used the Dhrystone 2.1 benchmark with
the standard glibc (strcpy, strcmp, ...) on one part, and with
the freescale SPE library on the other part (vstrcpy, vstrcmp, ...).

I already verified in the binary elf file that the right functions are
called.
When I run the benchmark, I get the same MIPS with and without SPE code.

I ran the same benchmark on the same board without OS,
with a personal pseudo glibc, I have the same MIPS as under Linux,
with the freescale library, I gain 40% of perf.

That's I want to retreive with the Linux OS.

Regards
Gérard
