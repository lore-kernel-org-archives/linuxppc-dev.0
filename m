Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 55D3EDDE10
	for <linuxppc-dev@ozlabs.org>; Sat, 10 May 2008 06:28:38 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m49KSZKk003246
	for <linuxppc-dev@ozlabs.org>; Fri, 9 May 2008 16:28:35 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m49KSZQp110894
	for <linuxppc-dev@ozlabs.org>; Fri, 9 May 2008 16:28:35 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m49KSZBZ026382
	for <linuxppc-dev@ozlabs.org>; Fri, 9 May 2008 16:28:35 -0400
Date: Fri, 9 May 2008 15:26:42 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Giuseppe Coviello" <cjg@cruxppc.org>
Subject: Re: [PATCH] Sam440ep support
Message-ID: <20080509152642.27f3e779@zod.rchland.ibm.com>
In-Reply-To: <a265241c0805090853s22f572c0t8f17c7ba89efd6aa@mail.gmail.com>
References: <a265241c0805051123h595123edrd46bf65a8099c3c2@mail.gmail.com>
	<a265241c0805060937m25921c56o6fb2b132a3f821d6@mail.gmail.com>
	<a265241c0805090853s22f572c0t8f17c7ba89efd6aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 9 May 2008 17:53:47 +0200
"Giuseppe Coviello" <cjg@cruxppc.org> wrote:

> 2008/5/6 Giuseppe Coviello <cjg@cruxppc.org>:
> > I've prepared another path to add the support for the sam440ep;
> > shortly I've merged arch/powerpc/boot/sam440ep.c in
> > arch/powerpc/boot/cuboot-sam440ep.c; I've inserted the code to make
> > the rtc works directly in arch/powerpc/platforms/44x/sam440ep.c (so
> > there isn't any arch/powerpc/sysdev/sam440ep.c anymore), and I've
> > cutted away the nasty hack (dma-mapping.h and memmalloc.c) to make the
> > sound works.
> [cut]
> 
> Sorry for our impatience, but we'll happy to know if this (second)
> version of the patch
> is acceptable, and, of course, what could be the future of this same patch.

It still isn't split up quite as much as I'd like, but I'll review it
over the weekend.  If there is nothing drastically wrong with it, I'll
probably take it for 2.6.27.

If you can provide a useful changelog message, that would be nice.
Otherwise I'll have to make one up myself.  (Like, what is the sam440ep
board?  Who makes it?  What is it's purpose?)

josh
