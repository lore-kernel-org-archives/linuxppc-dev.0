Return-Path: <tmarri@amcc.com>
Received: from sdcmail02.amcc.com (sdcmail02.amcc.com [198.137.200.73])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id C205CDDDA0
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Apr 2009 04:05:05 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: /dev/random on PPC40EXr
Date: Wed, 1 Apr 2009 10:05:00 -0700
Message-ID: <AC5E1C3367E37D44970B81A6ADD1DA2C071F4A5D@SDCEXCHANGE01.ad.amcc.com>
In-Reply-To: <22824979.post@talk.nabble.com>
References: <22824979.post@talk.nabble.com>
From: "Tirumala Reddy Marri" <tmarri@amcc.com>
To: "Felix Radensky" <felix@embedded-sol.com>,
	<linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There is PKA/TRNG driver for sure. Let me check if it was accepted in
opensource yet. Otherwise I will forward you the driver which may not be
there in opensource yet.


-----Original Message-----
From: linuxppc-dev-bounces+tmarri=3Damcc.com@ozlabs.org
[mailto:linuxppc-dev-bounces+tmarri=3Damcc.com@ozlabs.org] On Behalf Of
Felix Radensky
Sent: Wednesday, April 01, 2009 5:00 AM
To: linuxppc-dev@ozlabs.org
Subject: /dev/random on PPC40EXr


Hi,

On my custom board based on 405EXr /dev/random produces no output
at all, and /dev/urandom is not random enough for our purposes. Saving
entropy pool between reboots doesn't help much.

What can be done to increase the entropy of the system ?
I was thinking of adding IRQF_SAMPLE_RANDOM to network driver,
but since not too many drivers implement it, I don't know whether
it's a good idea or not.=20

Is there any work in progress to develop hw_random driver for 4xx
TRNG ?

Thanks a lot.

Felix.
--=20
View this message in context:
http://www.nabble.com/-dev-random-on-PPC40EXr-tp22824979p22824979.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
