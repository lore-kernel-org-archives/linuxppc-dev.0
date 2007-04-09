Return-Path: <MBenedict@twacs.com>
Received: from outbound1-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id E1593DDE16
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 Apr 2007 06:59:03 +1000 (EST)
Received: from outbound1-blu.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound1-blu-R.bigfish.com (Postfix) with ESMTP id C6088128BDCF
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  9 Apr 2007 20:58:59 +0000 (UTC)
Received: from mail126-blu-R.bigfish.com (unknown [10.1.252.3])
	by outbound1-blu.bigfish.com (Postfix) with ESMTP id A265112E004F
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  9 Apr 2007 20:58:59 +0000 (UTC)
Received: from mail126-blu (localhost.localdomain [127.0.0.1])
	by mail126-blu-R.bigfish.com (Postfix) with ESMTP id 5AC00FC00E5
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  9 Apr 2007 20:58:59 +0000 (UTC)
Received: from mail.twacs.com (unknown [68.89.149.4])
	by mail126-blu.bigfish.com (Postfix) with ESMTP id 039C120052
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  9 Apr 2007 20:58:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: MPC 8349e-mITX and MTD/Flash
Date: Mon, 9 Apr 2007 15:58:39 -0500
Message-ID: <CF7E46FCFF66AD478BB72724345289EC2795D1@twx-exch01.twacs.local>
From: "Benedict, Michael" <MBenedict@twacs.com>
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

Hello,
	Quite simply, I am trying to access the attached flash devices
for this platform from linux.  I tried to select all the appropriate MTD
settings that I thought could apply.  However, nothing shows up in
/proc/mtd.  Can someone point me in the right direction for accessing
these?  =09

>From the documentation: "The two Flash memory banks are MX29LV640MTTC-90
top boot Flash memory devices"

	Thank you!
		Michael
