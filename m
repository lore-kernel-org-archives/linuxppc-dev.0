Return-Path: <stephane.fillod@thomson.net>
Received: from dmzraw4.extranet.thmulti.com (dmzraw4.extranet.thmulti.com
	[141.11.234.72]) by ozlabs.org (Postfix) with ESMTP id B5C3567B16
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 10 Apr 2006 22:46:27 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Accessing physical memory
Date: Mon, 10 Apr 2006 14:43:14 +0200
Message-ID: <1CFEB358338412458B21FAA0D78FE86D042A2FFA@rennsmail02.eu.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@thomson.net>
To: "Antonio Di Bacco" <antonio.dibacco@aruba.it>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Antonio Di Bacco wrote:
>How can I access the physical memory? Can I MMAP for example /dev/mem?
Is=20
>there a simpler way?

Your question is a linuxppc-embedded FAQ.
It is documented in Denx's FAQ[1], and accessible through shorter
URL[2].
For more information, please follow this thread[3] (not ppc specific
actually).

[1]
http://www.denx.de/twiki/bin/view/PPCEmbedded/DeviceDrivers#Section_Acce
ssingPeripheralsFromUserSpace
[2] http://tinyurl.com/6c7th
[3] http://lists.linuxppc.org/linuxppc-embedded/200403/msg00059.html

CIAO,
--=20
Stephane
