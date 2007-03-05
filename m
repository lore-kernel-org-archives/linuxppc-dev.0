Return-Path: <stephane.fillod@thomson.net>
Received: from dmzraw3.extranet.thmulti.com (dmzraw3.extranet.thmulti.com
	[141.11.234.71]) by ozlabs.org (Postfix) with ESMTP id 4E8D4DDF59
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Mar 2007 02:12:39 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Endianness versus too many byte swaps??
Date: Mon, 5 Mar 2007 16:12:27 +0100
Message-ID: <0B45E93C5FF65740AEAE690BF3848B7A4AAFD5@rennsmail04.eu.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@thomson.net>
To: "Charles Krinke" <ckrinke@istor.com>,
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

Charles Krinke wrote:
[...]
>I am told that we are running this ppc in big endian, so would this
mean
>that readl & writel should actually be resolving to in_be32/out_be32
>respectively? Is there some other setup that may be wrong?

IIRC, readl and writel were defined this way in order to ease PCI driver

portability from x86 PC centric world to big-endian arch's.

That's why now I'm always using in_be*/out_be*/in_le*/out_le*, to make
things explicit, and let the header files do the swapping if need be.

Regards
--=20
Stephane
