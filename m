Return-Path: <ckrinke@istor.com>
Received: from stork.inside.istor.com (stork.istor.com [12.170.66.34])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 23CB8DDF28
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 May 2007 06:19:10 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: How do external irq's get mapped?
Date: Thu, 3 May 2007 13:19:08 -0700
Message-ID: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A203@MERCURY.inside.istor.com>
In-Reply-To: <305AA45A-EF86-4661-80F6-AA1996893A3D@freescale.com>
From: "Charles Krinke" <ckrinke@istor.com>
To: "Andy Fleming" <afleming@freescale.com>
Cc: Randy Brown <rbrown@istor.com>, Chris Carlson <ccarlson@istor.com>,
	Kevin Smith <ksmith@istor.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Andy:

I want to thank you and your group for getting us off the externalIRQ
block. Using irq =3D 128 allows the external device to interrupt on IRQ0
to the 8541.

I know it was a long, drawn-out explanation, but the help in
understanding is much appreciated.

Charles Krinke
