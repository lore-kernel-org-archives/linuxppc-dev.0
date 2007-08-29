Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7C353DDD09
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Aug 2007 07:38:33 +1000 (EST)
Date: Wed, 29 Aug 2007 16:38:24 -0500
From: Scott Wood <scottwood@freescale.com>
To: melinda develey <melinda.develey70@yahoo.com>
Subject: Re: spin_lock doesn't work?!?
Message-ID: <20070829213824.GA16082@ld0162-tx32.am.freescale.net>
References: <177333.15506.qm@web63904.mail.re1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <177333.15506.qm@web63904.mail.re1.yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Aug 29, 2007 at 02:26:15PM -0700, melinda develey wrote: I
> discovered that I called spin_lock two times consecutively without
> calling spin_unlock but my code didn't lock (I was managing an ioctl). 
> Probably I didn't understand how spin_lock works!!!!

spinlocks are no-ops on uniprocessor without preemption.

-Scott
