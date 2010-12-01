Return-Path: <jkenisto@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e37.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 83F3FB6EE9
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Dec 2010 18:25:08 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e37.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id oB17MfTS012374
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Dec 2010 00:22:41 -0700
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	oB17OxZn216288
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Dec 2010 00:24:59 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id oB17OwAN016881
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Dec 2010 00:24:58 -0700
Subject: Re: [PATCH 01/13] powerpc/nvram: Move things out of asm/nvram.h
From: Jim Keniston <jkenisto@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
In-Reply-To: <1291096063-14386-1-git-send-email-benh@kernel.crashing.org>
References: <1291096063-14386-1-git-send-email-benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 30 Nov 2010 23:24:56 -0800
Message-ID: <1291188297.2842.3.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, jkensito@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-11-30 at 16:47 +1100, benh@kernel.crashing.org wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> This moves a bunch of definitions out of asm/nvram.h to the files
> that use them or just outright remove completely unused stuff.
> 
> We leave the partition signatures definitions, they will be useful
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

I applied the whole 13-patch set, and built and booted the result.
Seems fine.

Tested-by: Jim Keniston <jkenisto@us.ibm.com>

Jim
