Return-Path: <cdumoulin@ics-ltd.com>
Received: from mx4.magma.ca (mx4-3.spamtrap.magma.ca [209.217.78.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4721FDDEDC
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Apr 2007 06:31:00 +1000 (EST)
Received: from mail3.magma.ca (mail3.internal.magma.ca [10.0.10.13])
	by mx4-3.spamtrap.magma.ca (8.13.1/8.13.1) with ESMTP id l3AK263n023463
	for <linuxppc-embedded@ozlabs.org>; Tue, 10 Apr 2007 16:02:06 -0400
Received: from randa ([64.26.174.130])
	by mail3.magma.ca (Magma's Mail Server) with ESMTP id l3AK240R008519
	for <linuxppc-embedded@ozlabs.org>; Tue, 10 Apr 2007 16:02:05 -0400
Message-Id: <200704102002.l3AK240R008519@mail3.magma.ca>
From: "Christopher Dumoulin" <cdumoulin@ics-ltd.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: RE: Multiple Boards with same MAC addresses - problem.
Date: Tue, 10 Apr 2007 16:02:12 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <mailman.536.1176223651.26657.linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Do you have some non-volatile memory to work with? You could store MAC
addresses for each individual board in non-volatile memory, then read the
MAC address from there each time U-Boot runs, and program your Ethernet
ports accordingly.

----------------------------------------------------------------------

Message: 1
Date: Tue, 10 Apr 2007 16:51:04 +0200
From: powerpc440 <powerpc440@googlemail.com>
Subject: Multiple Boards with same MAC addresses - problem.
To: linuxppc-embedded@ozlabs.org
Message-ID: <461BA458.2010605@googlemail.com>
Content-Type: text/plain; charset=ISO-8859-1

Hello all,

I have multiple boards, based on ppc405ep (which include on-chip two
ethernet ports). I'm configure the MAC address in u-boot and all works
great. The problem appears when I use two or more boards in one network,
because the MAC addresses are the same. Now I'm making a own u-boots for
each board, but this solution is not very comfortable.
My question is, which is the standard way to resolve such problem? I
would have only one generic u-boot. Is this possible?


Best regards,

Zhivko Yordanov


------------------------------
