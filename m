Return-Path: <Martin.Leisner@xerox.com>
Received: from wbmler3.mail.xerox.com (wbmler3.mail.xerox.com [13.13.138.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wbmler3.mail.xerox.com",
	Issuer "wbmler3.mail.xerox.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 185BADDFAC
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Jun 2007 05:56:27 +1000 (EST)
Received: from wbmlir3.mail.xerox.com (wbmlir3.mail.xerox.com [13.131.8.223])
	by wbmler3.mail.xerox.com (8.13.8/8.13.6) with ESMTP id
	l57JuM4p029007
	for <linuxppc-embedded@ozlabs.org>; Thu, 7 Jun 2007 15:56:22 -0400
Received: from wbmlir3.mail.xerox.com (localhost [127.0.0.1])
	by wbmlir3.mail.xerox.com (8.13.8/8.13.6) with ESMTP id l57Ju2T7006036
	for <linuxppc-embedded@ozlabs.org>; Thu, 7 Jun 2007 15:56:02 -0400
Received: from USA0300GW002.na.xerox.net (usa0300gw002.na.xerox.net
	[13.135.210.15])
	by wbmlir3.mail.xerox.com (8.13.8/8.13.6) with ESMTP id l57Ju0wo005858
	for <linuxppc-embedded@ozlabs.org>; Thu, 7 Jun 2007 15:56:02 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: how are the interrupts mapped on the taiga board?
Date: Thu, 7 Jun 2007 15:55:56 -0400
Message-ID: <556445368AFA1C438794ABDA8901891C066B5AC5@usa0300ms03.na.xerox.net>
From: "Leisner, Martin" <Martin.Leisner@xerox.com>
To: <linuxppc-embedded@ozlabs.org>
Cc: "Lund, Nathan" <Nathan.Lund@xerox.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm looking at mpc7448hpc2.dts -- and the tsi108 specs...

I see how TTYS0 is IRQ12 and the ethernet is IRQ16...that agrees with
the file...
and the tundra TSi108 spec.

But in after we boot in /proc/interrupts:

 16:       1796  Tsi108_PIC Edge      serial
 18:      24148  Tsi108_PIC Level     eth0

I don't see in the .dts a mapping from 12->16 and 16->18.
Nore have I found anything in the source...

I using 2.6.21.1.

How is this done?

marty
