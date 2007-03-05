Return-Path: <ckrinke@istor.com>
Received: from stork.inside.istor.com (stork.istor.com [12.170.66.34])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 45709DDF71
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Mar 2007 02:15:01 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Endianness versus too many byte swaps??
Date: Mon, 5 Mar 2007 07:14:56 -0800
Message-ID: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A185@MERCURY.inside.istor.com>
From: "Charles Krinke" <ckrinke@istor.com>
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

Thank you Stephane and Kumar.

I think the moral of this story is that the drive logic created by my
predecessor that calls readl/writel to read/write ppc registers needs to
be changed to call in_be32 & outbe32 so I don't continue a mistake.

Charles
