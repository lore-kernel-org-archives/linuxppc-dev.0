Return-Path: <jalmeida@apes.fr>
Received: from mail.apes.fr (unknown [80.125.80.241])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C667567A71
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Feb 2005 22:05:41 +1100 (EST)
Received: from [172.24.10.13] (jose.apes.fr [172.24.10.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.apes.fr (Postfix) with ESMTP id 7B949634397
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Feb 2005 11:41:52 +0100 (CET)
Message-ID: <421B0C70.1070301@apes.fr>
Date: Tue, 22 Feb 2005 11:41:52 +0100
From: Jose Almeida <jalmeida@apes.fr>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: FCC on 8560 ADS
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

All,

I'm trying to get a linux 2.6 kernel up and running on an freescale 8560 
ADS board. I have every peace of this up and running apart from the FCC 
ethernet.

I've switched to the legacy mode, which now allow me to talk to the PHY 
and negocite properly @ 100BT FD.

But I don't seem to get any ethernet packet going out. The FCC 
controller does not seem to read the BDs, and all the packet's I'm 
placing in the BD just stay there for ever !

I'm wondering if you have a driver which works properlly ? I'm thinking 
on some wrong setup in the ioports, but is all seems to be correct !

I'm using a 2.6.9 kernel, but I also tryed other versions (2.6.11r4), 
with the same problems ...

Thanks
 Jose
