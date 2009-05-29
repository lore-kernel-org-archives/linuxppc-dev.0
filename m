Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 53CE8DDF87
	for <linuxppc-dev@ozlabs.org>; Sat, 30 May 2009 03:09:16 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n4TH9BST021766
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 10:09:11 -0700 (MST)
Received: from b07421-ec1.am.freescale.net (b07421-ec1.am.freescale.net
	[10.82.121.43])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n4TH9A1M022732
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 12:09:10 -0500 (CDT)
Date: Fri, 29 May 2009 12:09:10 -0500
From: Scott Wood <scottwood@freescale.com>
To: Nancy Isaac <nancy.isaac@pobox.com>
Subject: Re: 8544 external interrupt configuration problems
Message-ID: <20090529170909.GA22066@b07421-ec1.am.freescale.net>
References: <1bcc666d0905281205p63ee8119td5578a749bce8377@mail.gmail.com>
	<20090528200215.GA9793@b07421-ec1.am.freescale.net>
	<1bcc666d0905281848m5d237742h12b4bac272f28ca9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1bcc666d0905281848m5d237742h12b4bac272f28ca9@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 28, 2009 at 06:48:48PM -0700, Nancy Isaac wrote:
> > Is the level/sense information correct?
> 
> 
> [NI] Yes, these interrupts are supposed to be active low, level sensitive
> interrupts.

But the level/sense value for that on mpic is 1, not 2.  2 is active
high (see Documentation/powerpc/booting-without-of.txt).

-Scott
