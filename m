Return-Path: <yuli@arabellasw.com>
Received: from gold.webfusion.co.uk (gold.webfusion.co.uk [212.67.202.159])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 371F767A81
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Feb 2005 20:35:42 +1100 (EST)
From: Yuli Barcohen <yuli@arabellasw.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16913.49754.941663.495671@astp0002.localdomain>
Date: Tue, 15 Feb 2005 11:35:22 +0200
To: Markus Westergren <markus.westergren@biologigrand.ac>
In-Reply-To: <Pine.LNX.4.50.0502142031110.28518-100000@220a.licentiaten.umea.hsb.se>
References: <Pine.LNX.4.50.0502131246140.3196-100000@220a.licentiaten.umea.hsb.se>
	<16912.18711.885679.679568@astp0002.localdomain>
	<Pine.LNX.4.50.0502142031110.28518-100000@220a.licentiaten.umea.hsb.se>
Cc: linuxppc-embedded@ozlabs.org
Subject: (no subject)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> Markus Westergren writes:

    Markus> The board in my project is almost like a Adder875 but unlike
    Markus> the Adder it has a PCMCIA slot connected.

No problems, it's supported

    Markus> I have tested a version of Arabella (FREE v2.1, kernel
    Markus> 2.4.25). It looks like that the fec driver only supports
    Markus> general PHY and no link interrupts.

Yes, because nobody of our customers needed PHY-specific support. It's
trivial to add if necessary.

-- 
========================================================================
 Yuli Barcohen       | Phone +972-9-765-1788 |  Software Project Leader
 yuli@arabellasw.com | Fax   +972-9-765-7494 | Arabella Software, Israel
========================================================================
