Return-Path: <Atit_Shah@satyam.com>
Received: from njpmail.satyam.com (njpmail.satyam.com [204.179.188.132])
	by ozlabs.org (Postfix) with ESMTP id ABD5867A33
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 18 Apr 2005 14:33:01 +1000 (EST)
Received: from blr.satyam.com (blr.satyam.com [208.220.245.73])
	by njpmail.satyam.com (8.11.6/8.11.6) with ESMTP id j3I4OlI07926
	for <linuxppc-embedded@ozlabs.org>; Mon, 18 Apr 2005 00:25:13 -0400
Received: from Disclaimerbng.corp.satyam.ad
	(IDENT:Ct8VY2Q9ENm0Y/Kcr0nDVXB+11sj+YHv@localhost [127.0.0.1])
	by blr.satyam.com (8.11.6/8.11.6) with ESMTP id j3I4RTL09673
	for <linuxppc-embedded@ozlabs.org>; Mon, 18 Apr 2005 09:57:29 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Mon, 18 Apr 2005 10:01:27 +0530
Message-ID: <D8595042F3765A4285B848A78A2C2ED1027748@bsdmsg002.corp.satyam.ad>
From: "Atit_Shah" <Atit_Shah@satyam.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Impact of change n port size
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All,

	I have a kernel image which works perfectly for my reference
board. When I try to port the same image on my board I seem to be facing
problems. The only difference I see between the reference board and my
board is the port size and capacity of RAM.=20
	I have taken care of sending the right value for the RAM size
through BD_INFO. Would there be and where all would the change be, if
any, in the kernel code OR when I make the kernel image ie through "make
menuconfig" / "menu xconfig" required to be made for port size of RAM?
	Out of curiosity what would be the change required for different
FLASH port size again on the kernel side.
=09
Thanks and Regards
Atit


DISCLAIMER:
This email (including any attachments) is intended for the sole use of =
the intended recipient/s and may contain material that is CONFIDENTIAL =
AND PRIVATE COMPANY INFORMATION. Any review or reliance by others or =
copying or distribution or forwarding of any or all of the contents in =
this message is STRICTLY PROHIBITED. If you are not the intended =
recipient, please contact the sender by email and delete all copies; =
your cooperation in this regard is appreciated.
