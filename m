Return-Path: <DWatkins@tranzeo.com>
Received: from mail.tranzeo.com (unknown [64.114.87.10])
	by ozlabs.org (Postfix) with ESMTP id 64972DDF46
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 Apr 2008 06:47:49 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Ethernet Jumbo Frames
Date: Mon, 31 Mar 2008 13:47:46 -0700
Message-ID: <D61182AC8012EA4EBC531B3AF23BE109582F00@tranzeo-mail2.12stewart.tranzeo.com>
From: "Darcy Watkins" <DWatkins@tranzeo.com>
To: "LinuxPPC-Embedded" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Has anyone on this list ever been given a requirement to implement
support for ethernet frames larger than the standard MTU of 1500?  ...

... for normal 10/100 Ethernet?   ... not gigabit.

The application is to support certain encapsulation protocols without
imposing smaller than 1500 byte MTU restrictions on the innermost
protocol.

I have been tasked to investigate this for a system based on PPC405EP.
Can it be done using the IBM EMAC, Linux drivers, etc?

Regards,

Darcy
