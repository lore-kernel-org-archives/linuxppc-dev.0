Return-Path: <flucifredi@acm.org>
Received: from mail2.speakeasy.net (mail2.speakeasy.net [216.254.0.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C66802BF18
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  8 Jan 2005 08:16:18 +1100 (EST)
Received: from blhealthcare.com (HELO [192.168.1.201])
	(blsoftware@[151.204.230.210]) (envelope-sender <flucifredi@acm.org>)
	by mail2.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
	for <linuxppc-embedded@ozlabs.org>; 7 Jan 2005 21:16:03 -0000
Message-ID: <41DEFB89.5060404@acm.org>
Date: Fri, 07 Jan 2005 16:13:45 -0500
From: Federico Lucifredi <flucifredi@acm.org>
MIME-Version: 1.0
To: "Linux-ppc [mailing list]" <linuxppc-embedded@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Frame Buffer and Y Cb Cr
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello All,
    I am working on a fb driver for linux in an embedded PPC setup. I 
have it working as far as linux is concerned, and I also understand the 
video card side of the problem.

    My trouble is: Linux sends me R G B and the hardware expects Y Cb 
Cr. As things work through a memory-mapped file, I am at a loss for an 
"intelligent" way to intercept and convert these values.

    Any suggestions ?

    Best - Federico

-- 
_________________________________________
-- "'Problem' is a bleak word for challenge" - Richard Fish

Muad'Dib of Caladan (Federico L. Lucifredi)- Harvard University & BU
http://metcs.bu.edu/~lucifred
