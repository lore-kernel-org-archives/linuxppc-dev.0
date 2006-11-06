Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net
	[151.189.21.44])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 14F7E67D6E
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Nov 2006 03:46:01 +1100 (EST)
In-Reply-To: <454F5259.3020107@hogyros.de>
References: <1162767333.28571.254.camel@localhost.localdomain>
	<454F5259.3020107@hogyros.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <8BC8EB4A-7010-446B-8605-BAB2404AE840@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: APUS and IOs question
Date: Mon, 6 Nov 2006 17:45:43 +0100
To: Simon Richter <Simon.Richter@hogyros.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> That, and that the 604e+ probably doesn't reorder accesses that much
> anyway that the barriers would do any good here. :-)

Is there any reason though to have APUS-specific I/O accessors
instead of using the generic stuff (except for perhaps a minor
performance hit)?


Segher
