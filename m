Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 287BD68841
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 26 Nov 2005 02:31:33 +1100 (EST)
Received: from zambia.cambridgebroadband.com (cbluk-gw0.cambridgebroadband.com
	[217.204.121.82])
	by cambridgebroadband.com (8.12.8/8.12.8) with SMTP id jAPFVQBH027352
	for <linuxppc-embedded@ozlabs.org>; Fri, 25 Nov 2005 15:31:26 GMT
Date: Fri, 25 Nov 2005 15:31:26 +0000
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: linuxppc-embedded@ozlabs.org
Message-Id: <20051125153126.0385ddef.ajz@cambridgebroadband.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: MPC8272ADS stability issues
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I have a question that is a bit off topic here, but you seem the most
knowledgable people to ask so please don't flame me... :)

I am using an MPC8272ADS development board.  I was wondering if
anybody on this list experienced hardware reliability problems with
this platform.

I am running ELDK 3.1.1.  I have seen the kernel hang several times,
and a Oops a few times too.  The reason I suspect that this is a
hardware problem is that these seem to happen at completely random
times, and the Oopses, in random places.  It doesn't seem to make
any difference whether I have any of my own modules loaded or not, and
I've even seen these problems occur in the bootloader.

I'm hoping for an answer along the lines of "Ah, you must have the
'fail randomly' dip switch set!"

TIA,

Alex
