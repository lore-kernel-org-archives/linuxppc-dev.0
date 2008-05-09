Return-Path: <gicoviello@gmail.com>
Received: from gv-out-0910.google.com (gv-out-0910.google.com [216.239.58.184])
	by ozlabs.org (Postfix) with ESMTP id 272CBDDE08
	for <linuxppc-dev@ozlabs.org>; Sat, 10 May 2008 01:54:37 +1000 (EST)
Received: by gv-out-0910.google.com with SMTP id y18so185776gvf.14
	for <linuxppc-dev@ozlabs.org>; Fri, 09 May 2008 08:53:48 -0700 (PDT)
Message-ID: <a265241c0805090853s22f572c0t8f17c7ba89efd6aa@mail.gmail.com>
Date: Fri, 9 May 2008 17:53:47 +0200
From: "Giuseppe Coviello" <cjg@cruxppc.org>
Sender: gicoviello@gmail.com
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Sam440ep support
In-Reply-To: <a265241c0805060937m25921c56o6fb2b132a3f821d6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <a265241c0805051123h595123edrd46bf65a8099c3c2@mail.gmail.com>
	<a265241c0805060937m25921c56o6fb2b132a3f821d6@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

2008/5/6 Giuseppe Coviello <cjg@cruxppc.org>:
> I've prepared another path to add the support for the sam440ep;
> shortly I've merged arch/powerpc/boot/sam440ep.c in
> arch/powerpc/boot/cuboot-sam440ep.c; I've inserted the code to make
> the rtc works directly in arch/powerpc/platforms/44x/sam440ep.c (so
> there isn't any arch/powerpc/sysdev/sam440ep.c anymore), and I've
> cutted away the nasty hack (dma-mapping.h and memmalloc.c) to make the
> sound works.
[cut]

Sorry for our impatience, but we'll happy to know if this (second)
version of the patch
is acceptable, and, of course, what could be the future of this same patch.

Thank you, Giuseppe
