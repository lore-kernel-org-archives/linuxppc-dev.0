Return-Path: <alebas@televes.com>
Received: from tvesnat.televes.com (unknown [212.163.42.137])
	by ozlabs.org (Postfix) with ESMTP id E4FC32BEA0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Nov 2004 22:25:44 +1100 (EST)
Message-ID: <1100777521.419c88313395f@webmail.televes.com:443>
Date: Thu, 18 Nov 2004 12:32:01 +0100
From: alebas@televes.com
To: "VanBaren, Gerald (AGRE)" <Gerald.VanBaren@smiths-aerospace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: u-boot-users@lists.sourceforge.net, linuxppc-embedded@ozlabs.org
Subject: mpc8272ads lowboot ... I got it
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

Wooouh, this morning I was sleeping.
I have post the mail to the wrong list and with the wrong Subject (sorry
to those in the linuxppc-embedded list).

Well, I finally got uboot-lowboot working. The problem was in the CS6PC
bits (24-25) in the HRCW (i think these are the same than CS10PC bits in
the PQ2ADS). This must be configured as CS6 (00), not as BCTL1 (01).

So, the HRCW for lowboot in the MPC8272ADS i have used is 0x0E_74_B2_0A.

Now it works great. Thanks Gerald.

Will the patch finally include the different HRCWs? At least, this
should be documented, shouldn't it?

Alex
