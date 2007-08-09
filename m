Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp06.au.ibm.com (ausmtp06.au.ibm.com [202.81.18.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A239ADDE9A
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 13:09:03 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by ausmtp06.au.ibm.com (8.13.8/8.13.8) with ESMTP id l793BYC42154556
	for <linuxppc-dev@ozlabs.org>; Thu, 9 Aug 2007 13:11:34 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.250.244])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l79390nm4464794
	for <linuxppc-dev@ozlabs.org>; Thu, 9 Aug 2007 13:09:00 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l79390pf003907
	for <linuxppc-dev@ozlabs.org>; Thu, 9 Aug 2007 13:09:00 +1000
Date: Thu, 9 Aug 2007 13:08:56 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Jerone Young <jyoung5@us.ibm.com>
Subject: Re: Sequoia 440EPx patches not working
Message-ID: <20070809030856.GC8261@localhost.localdomain>
References: <1186598710.5459.7.camel@laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1186598710.5459.7.camel@laptop>
Cc: linuxppc-dev@ozlabs.org, vbarshark@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 08, 2007 at 01:45:10PM -0500, Jerone Young wrote:
> Using the Sequoia (AMCC 440EPx) patches recently submitted to the list I
> am unable to boot to fully boot a uImage built with these patches under
> Uboot. It appears to hang in very early boot.

I'm guessing this is an old version of u-boot, that's not device tree
aware.  That would need a cuImage, not a uImage, and IIRC the posted
patches didn't yet have cuboot support for Sequoia.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
