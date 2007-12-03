Return-Path: <michael.firth@bt.com>
Received: from smtp4.smtp.bt.com (smtp4.smtp.bt.com [217.32.164.151])
	by ozlabs.org (Postfix) with ESMTP id 2DE5CDDE3A
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  3 Dec 2007 20:28:17 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Advice on how to add support for non-standard Ethernet PHY
Date: Mon, 3 Dec 2007 09:25:47 -0000
Message-ID: <36D7B34A3A79F84F82FA0C154F299F2505FE26E3@E03MVX1-UKDY.domain1.systemhost.net>
From: <michael.firth@bt.com>
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

We have a board that is using an Ethernet PHY where the registers are
accessed 'indirectly' - i.e. to read or write a given register you set a
value to one specific register, and read the results back from another
specific register.

Unfortunately, these two registers are the only ones implemented, which
means that the normal PHY detection code in Linux does not work, as the
ID registers are also indirect.

Does anyone have any advice on an elegant way of adding support for this
type of PHY, or should I just add a special case to the get_phy_device()
function?

Thanks

Michael
