Return-Path: <postmaster@246tNt.com>
Received: from ns30619.ovh.net (ns30619.ovh.net [213.186.47.155])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 53C0A67C3D
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Jul 2005 20:30:56 +1000 (EST)
Message-ID: <1120645451.42cbb14b63b9c@webmail.ecat.be>
Date: Wed, 06 Jul 2005 12:24:11 +0200
From: postmaster@246tNt.com
To: Frederic Janot <f.janot@ateme.fr>
References: <00aa01c5807d$192ca230$b31010ac@pc179>
In-Reply-To: <00aa01c5807d$192ca230$b31010ac@pc179>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: mpc5200 i2c bus problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi

> I send a message here to indicate an hardware problem with mpc5200 i2c
> module. This bug is not describe in the mpc5200 errata document.
> I can reproduce it on revA and revB of the silicium. After contacting
> Freescale, they recognize the problem.
> 
> The problem is that, sometime, the 9th pulse clock on SCL is missing !!!!
> I can send a scope screen capture which shows that if someone wants.


Well, at the end of the day, you might be better by using two GPIO to do I2C
bit-banging ... Thanks for sharing the info, that might spare us long hours of
searching were the problem lies.

Unfortunatly the I2C port on the 5200 can't be turned to GPIO so that requires
some hardware modification ;(



    Sylvain




----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.
