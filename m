Return-Path: <tim.martin@viasat.com>
Received: from VCAEXCH02.hq.corp.viasat.com (kestrel.viasat.com
	[199.106.52.139]) by ozlabs.org (Postfix) with ESMTP id 8DB2767A6D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Apr 2006 09:47:49 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: PPC Linux support for Tundra TSI148
Date: Tue, 25 Apr 2006 16:47:45 -0700
Message-ID: <821B2170E9E7F04FA38DF7EC21DE487104970DA7@VCAEXCH01.hq.corp.viasat.com>
From: "Martin, Tim" <tim.martin@viasat.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Does anyone out there have any real world measured performance of a
Linux PowerPC (kernel module + user space application) doing 2eSST VME
transfers with the Tundra TSI148 chipset?

Tundra has a Linux driver available for the Motorola MVME6100 , but told
me they don't have any performance data available.  I'm looking for
sustained throughput rates, not the peak burst rates (e.g. 320 MBps, 267
MBps).

Thanks!
Tim
