Return-Path: <chiradeep@matissenetworks.com>
Received: from matisse01.matissenetworks.com
	(h-66-166-77-18.snvacaid.covad.net [66.166.77.18])
	by ozlabs.org (Postfix) with ESMTP id 756EE67A6B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Apr 2005 03:59:14 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Date: Wed, 27 Apr 2005 10:46:38 -0700
Message-ID: <F237EFC9919B064C8BF5A44CDA5DA0C212F678@matisse01.matissenetworks.com>
From: "Chiradeep Vittal" <chiradeep@matissenetworks.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Linux Kernel Issue: MPC8540 Errata (CPU29)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

We're running Linux Kernel 2.4.26 on an 8540 ADS derivative. We're
seeing an=20
"illegal instruction"  (SIGILL) exception under some circumstances=20
(during a pthread_create call). We were wondering if this could be a
symptom of=20
CPU29 and if there is a patch available for CPU29.

"CPU29 L1 instruction cache gets multiple entries for same line after
change=20
in MSR[IS] bit "

www.freescale.com/files/32bit/doc/errata/MPC8540CE.pdf


Thanks
--
Chiradeep Vittal
Matisse Networks Inc.=20
