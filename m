Return-Path: <martyn.welch@gefanuc.com>
Received: from ext-cn0ut-8.online-age.net (Ext-cn0ut-8.online-age.net
	[63.210.253.238])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-cn0ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 52647DDF8F
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jun 2008 02:17:52 +1000 (EST)
Received: from int-cn0ut-1.online-age.net (int-cn0ut-1.online-age.net
	[3.159.252.70])
	by ext-cn0ut-8.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id m5NE1ORk000365
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jun 2008 10:01:29 -0400
Received: from cinmlef08.e2k.ad.ge.com (int-cn0ut-1.online-age.net
	[3.159.252.70])
	by int-cn0ut-1.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id m5NE1Iaq020942
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jun 2008 10:01:22 -0400
Subject: Virqs of cascaded interrupt controller.
Date: Mon, 23 Jun 2008 15:00:35 +0100
Message-ID: <1CADFA951940554D86FBD8B24BBFF3A0017B35B9@LONMLVEM08.e2k.ad.ge.com>
From: "Welch, Martyn (GE EntSol,
	Intelligent Platforms)" <martyn.welch@gefanuc.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I'm in the process of porting Linux to one of our boards based on an
8641D. Some of the interrupts of on-board devices are dealt with by a
custom interrupt controller in one of the onboard FPGAs, which cascades
into the 8641D's mpic. I'm trying to write a driver for it.

Looking at examples of cascaded interrupt handlers I've managed to get
to the point where the kernel is trying to register interrupts from the
DTB file I provide it. The problem is I don't know what virqs are being
assigned to the interrupts or how virqs are/should be assigned to a
cascaded interrupt controller.

Can anyone point me towards any documentation that my naïve googling is
missing or explain how this should work?

Martyn

----
Martyn Welch MEng MPhil MIET
Principal Software Engineer

GE Fanuc Intelligent Platforms
Tove Valley Business Park, Towcester,
Northants, NN12 6PF, United Kingdom

Telephone: +44 (0) 1327 359444
Direct Dial: +44 (0) 1327 322748
Fax: +44 (0) 1327 322800
email: martyn.welch@gefanuc.com
web: www.gefanuc.com

GE Fanuc Intelligent Platforms Ltd, registered in England and Wales
(3828642) at 100 Barbirolli Square, Manchester, M2 3AB, VAT GB 729 849
476  

GE Fanuc Intelligent Platforms Confidential and Proprietary. If you have
received this message in error please notify us immediately and
permanently remove it from your system and destroy any printed
hardcopies.    
