Return-Path: <arvid.staub@mediornet.com>
Received: from mailbackup.inode.at (mailbackup.inode.at [213.229.60.24])
	by ozlabs.org (Postfix) with ESMTP id C1D4667C85
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Nov 2006 04:44:44 +1100 (EST)
Received: from [62.99.145.7] (port=31966 helo=mx.inode.at)
	by mailbackup.inode.at with esmtp (Exim 4.62)
	(envelope-from <arvid.staub@mediornet.com>) id 1Gh8WZ-0007cM-6i
	for linuxppc-embedded@ozlabs.org; Mon, 06 Nov 2006 18:44:43 +0100
Received: from [83.64.147.140] (port=6007 helo=mediornet.com)
	by smartmx-07.inode.at with esmtp (Exim 4.50) id 1Gh8WS-0002Np-Cz
	for linuxppc-embedded@ozlabs.org; Mon, 06 Nov 2006 18:44:36 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Linux 2.4 on AMCC Taihu eval board
Date: Mon, 6 Nov 2006 18:40:34 +0100
Message-ID: <8B59AE8CCFB44040B58FCBC1342ED3C414CC51@mnx.mediornet.lan>
From: "Arvid Staub" <Arvid.Staub@mediornet.com>
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

I'm currently working on a PPC405EP-based Taihu eval board by AMCC, and
I'd like to use a 2.4-series kernel instead of the supplied 2.6.
I don't need any fancy stuff, just ethernet, i2c and serial (although
PCI and mtd would probably fine, too...)

Has anybody done this?
Can I use any of the standard machine types, like "405EP-eval"?

Regards,=20
Arvid Staub
