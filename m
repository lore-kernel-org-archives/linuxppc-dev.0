Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F1DA9DDE21
	for <linuxppc-dev@ozlabs.org>; Mon, 19 May 2008 22:51:23 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4JCpCAM003158
	for <linuxppc-dev@ozlabs.org>; Mon, 19 May 2008 08:51:12 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4JCpBDC081512
	for <linuxppc-dev@ozlabs.org>; Mon, 19 May 2008 06:51:11 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4JCpBNI016032
	for <linuxppc-dev@ozlabs.org>; Mon, 19 May 2008 06:51:11 -0600
Date: Mon, 19 May 2008 07:47:01 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Giuseppe Coviello" <cjg@cruxppc.org>
Subject: Re: [PATCH] Sam440ep support
Message-ID: <20080519074701.4cb15c86@zod.rchland.ibm.com>
In-Reply-To: <a265241c0805060937m25921c56o6fb2b132a3f821d6@mail.gmail.com>
References: <a265241c0805051123h595123edrd46bf65a8099c3c2@mail.gmail.com>
	<a265241c0805060937m25921c56o6fb2b132a3f821d6@mail.gmail.com>
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

On Tue, 6 May 2008 18:37:57 +0200
"Giuseppe Coviello" <cjg@cruxppc.org> wrote:

> I've prepared another path to add the support for the sam440ep;
> shortly I've merged arch/powerpc/boot/sam440ep.c in
> arch/powerpc/boot/cuboot-sam440ep.c; I've inserted the code to make
> the rtc works directly in arch/powerpc/platforms/44x/sam440ep.c (so
> there isn't any arch/powerpc/sysdev/sam440ep.c anymore), and I've
> cutted away the nasty hack (dma-mapping.h and memmalloc.c) to make the
> sound works.
> 
>  arch/powerpc/boot/Makefile                  |    3 +-
>  arch/powerpc/boot/cuboot-sam440ep.c         |   49 ++
>  arch/powerpc/boot/dts/sam440ep.dts          |  292 +++++++
>  arch/powerpc/configs/44x/sam440ep_defconfig | 1192 +++++++++++++++++++++++++++
>  arch/powerpc/platforms/44x/Kconfig          |    9 +
>  arch/powerpc/platforms/44x/Makefile         |    1 +
>  arch/powerpc/platforms/44x/sam440ep.c       |   80 ++
>  7 files changed, 1625 insertions(+), 1 deletions(-)

Patch looks fine, but you're missing a Signed-off-by line.  Please read
section 12 of Documentation/SubmittingPatches and add that.

josh
