Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E2D9EDDDF7
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Nov 2007 06:33:43 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lA8JXenm004821
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Nov 2007 14:33:40 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	lA8JXefo085492
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Nov 2007 14:33:40 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lA8JXel9018407
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Nov 2007 14:33:40 -0500
Date: Thu, 8 Nov 2007 13:33:34 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: DTS Bytestrings Representation in /dts-v1/ files
Message-ID: <20071108133334.2aa3cef1@zod.rchland.ibm.com>
In-Reply-To: <E1IqCtu-0000ZE-Vi@jdl.com>
References: <E1IpWlT-0007Qd-IX@jdl.com>
	<20071106231120.GG31367@localhost.localdomain>
	<E1Iplfp-0003WY-MB@jdl.com> <E1IqCtu-0000ZE-Vi@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 08 Nov 2007 13:18:50 -0600
Jon Loeliger <jdl@jdl.com> wrote:

> 
> Folks,
> 
> When the new DTS /dts-v1/ support is released Real Soon Now,
> it will support C-like literal constants.  Hex values will be
> prefixed with 0x, binary with 0b, and bare numbers will be
> decimal unless they start with a leading 0.
> 
> One outstanding question on which I'd like some feedback
> is the issue of bytestring value representation.
> 
> Currently they look like this:
> 
>     stuff = [ 0b 31 22 de ea ad be ef ];
> 
> One opinion is to have them continue to look like that
> and be in hex only.
> 
> Another opinion is to allow the new, consistent  C-style
> literals and expressions so that one could have:
> 
>     new_stuff = [ 0x31 49 '1' 23 17 ];
> 
> Opinions?

My off-the-cuff opinion is to leave them as they are today.  They seem
to mostly be used for MAC addresses, and you don't really see a whole
lot of those with the 0x prefix before every number.

At the same time, inconsistency sucks.

josh
