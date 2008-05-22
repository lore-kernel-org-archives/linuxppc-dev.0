Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 96A45DE01C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 May 2008 07:54:38 +1000 (EST)
Message-ID: <4835EBD8.8060508@freescale.com>
Date: Thu, 22 May 2008 16:55:36 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Bruce_Leonard@selinc.com
Subject: Re: Question about "native" compiling
References: <OF2C9C3CB1.4A6FAC88-ON88257451.00760B81-88257451.00761D72@selinc.com>
In-Reply-To: <OF2C9C3CB1.4A6FAC88-ON88257451.00760B81-88257451.00761D72@selinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Bruce_Leonard@selinc.com wrote:
> If we do our compiles on a G5 is it really a 'native' compile or is
> it a cross-compile and we're back in the same boat as we were with
> the x86?  Should we use a G4 instead?

You can run 32-bit userspace on a G5 -- it's probably even the default 
in most distributions.

-Scott
