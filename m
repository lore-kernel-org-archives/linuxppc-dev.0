Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 8BBBFDDF8F
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Aug 2008 20:57:54 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1KOsKU-00028I-2h
	for linuxppc-embedded@ozlabs.org; Fri, 01 Aug 2008 03:57:50 -0700
Message-ID: <18772109.post@talk.nabble.com>
Date: Fri, 1 Aug 2008 03:57:50 -0700 (PDT)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: floating point support in the driver.
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi all,

I have a DSP algorithm which i am running in the application even after
enabling the VFP support it is taking a lot of time to get executed hence 

I want to transform the same into the driver insted of an user application.
Can anybody suggest whether doing the same could be a better solution and
what could be the chalenges that i have to face by implimenting such
floating point support in the driver.

Is there a way in the application itself to make it execute faster.

---- Misbah <>< 
-- 
View this message in context: http://www.nabble.com/floating-point-support-in-the-driver.-tp18772109p18772109.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
