Return-Path: <g.jaeger@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [62.8.134.5])
	by ozlabs.org (Postfix) with ESMTP id 5080CDDDF3
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Feb 2007 20:37:52 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.sysgo.com (Postfix) with ESMTP id AD069CC141
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Feb 2007 10:37:50 +0100 (CET)
Received: from donald.sysgo.com (unknown [172.20.1.30])
	by mail.sysgo.com (Postfix) with ESMTP id 6EC0DCC13E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Feb 2007 10:37:50 +0100 (CET)
Received: from gja.ulm.sysgo.com (unknown [172.30.1.130])
	by donald.sysgo.com (Postfix) with ESMTP id 6DCBC287869
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Feb 2007 10:37:50 +0100 (CET)
From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Could not create MTD Partitions
Date: Wed, 28 Feb 2007 10:37:49 +0100
References: <29DC34A6B43468409F5A371CFE34E8490B621B@ex01.ads.ubidyne.de>
In-Reply-To: <29DC34A6B43468409F5A371CFE34E8490B621B@ex01.ads.ubidyne.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702281037.49739.g.jaeger@sysgo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mittwoch, 28. Februar 2007, Frank Prepelica wrote:
> Well, actually I'm not sure. But I found some details
> In the manual:
> 
> 32x Bus DDR
> SDRAM w/ ECC
> 
> 32 MByte 
> 128 Mbit (8M x 16 bit) devices
> 2 Micron MT46V8M16TG-6T
> 4 MBytes x 4 banks x 2 devices = 32 MBytes total
> 2 bit bank address at 4[BA0,BA1]
> 12 bit row address at 4K [A0:A11]
> 9 bit column address at 512[A0:A8]
> 
> 64 MByte 
> 256 Mbit (16M x 16 bit) devices
> 2 Micron MT46V16M16TG-6T
> 8 MBytes x 4 banks x 2 devices = 64 MBytes total
> 2 bit bank address at 4[BA0,BA1]
> 13 bit row address at 8K [A0:A12]
> 9 bit column address at 512[A0:A8]
> 
> 128 MByte 
> 512 Mbit (32M x 16 bit) devices
> 2 Micron MT46V32M16TG-6T
> 16 MBytes x 4 banks x 2 devices = 128 MBytes total
> 2 bit bank address at 4[BA0,BA1]
> 13 bit row address at 8K [A0:A12]
> 10 bit column address at 1K[A0:A9]
> 
> 
> Are the details for the 64MByte corresponding to that post
> from Gerhard?
> 
> @Gerhard
> Here are some parts of my configuration regarding the MTD settings.
> Could you tell which I have to modify to get running the MTD partitions?
[SNIPSNAP]

The stuff above describe only the available RAM configurations, not the
flash. Checkout for AMD/Spansion chips (according to your earlier post)...

Your config should be okay, what I meant in my previous mail was, that
you should check your mapping driver regarding the bankwidth parameter.

- Gerhard

-- 
Gerhard Jaeger <gjaeger@sysgo.com>            
SYSGO AG                      Embedded and Real-Time Software
Lise-Meitner-Str. 15                    D-89081 Ulm / Germany
www.sysgo.com | www.elinos.com | www.pikeos.com | www.osek.de 
