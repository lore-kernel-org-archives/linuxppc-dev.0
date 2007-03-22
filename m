Return-Path: <hollis@penguinppc.org>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id ABD3EDDFCF
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 03:42:19 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2MGgAYm006935
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 12:42:10 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l2MGgA5C299882
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 12:42:10 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l2MGgAJh025378
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 12:42:10 -0400
Subject: Re: libfdt: going forward for u-boot
From: Hollis Blanchard <hollis@penguinppc.org>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20070322004959.GE2295@localhost.localdomain>
References: <4601C8F7.5060006@comcast.net>
	<20070322004959.GE2295@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 22 Mar 2007 11:42:06 -0500
Message-Id: <1174581726.22826.2.camel@basalt>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-03-22 at 11:49 +1100, David Gibson wrote:
> 
> I'm actually more inclined to just remove the #include from fdt.h
> entirely and require users to provide the stdint types, by whatever
> means, before they include fdt.h.  It's a bit icky, but I think it's
> the sanest way to allow building in multiple environment. 

I agree. I've done something similar in a few places now, and it's the
best solution I've found.

-Hollis
