Return-Path: <euphoria@arcor.de>
Received: from mail-in-14.arcor-online.net (mail-in-14.arcor-online.net
	[151.189.21.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7B6EBDDDFC
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Nov 2007 07:14:50 +1100 (EST)
Received: from mail-in-04-z2.arcor-online.net (mail-in-04-z2.arcor-online.net
	[151.189.8.16])
	by mail-in-14.arcor-online.net (Postfix) with ESMTP id 90FE51879F9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Nov 2007 21:14:32 +0100 (CET)
Received: from mail-in-17.arcor-online.net (mail-in-17.arcor-online.net
	[151.189.21.57])
	by mail-in-04-z2.arcor-online.net (Postfix) with ESMTP id 8056DABAE7
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Nov 2007 21:14:32 +0100 (CET)
Received: from [192.168.100.2] (e181025151.adsl.alicedsl.de [85.181.25.151])
	(Authenticated sender: florian.boelstler@arcor.de)
	by mail-in-17.arcor-online.net (Postfix) with ESMTP id 5659A2BB4EB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Nov 2007 21:14:32 +0100 (CET)
Message-ID: <473A05A5.5090800@arcor.de>
Date: Tue, 13 Nov 2007 21:14:29 +0100
From: Florian Boelstler <euphoria@arcor.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: OT: Strange delays / what usually happens every 10 min?
References: <47339E23.70806@arcor.de>
In-Reply-To: <47339E23.70806@arcor.de>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

For the sake of completeness: It is related to a flush operation of the
IP route cache, please see
http://thread.gmane.org/gmane.linux.kernel/602382.

Cheers,

  Florian
