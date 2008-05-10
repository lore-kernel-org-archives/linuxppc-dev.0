Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D6DABDDE21
	for <linuxppc-dev@ozlabs.org>; Sat, 10 May 2008 23:24:56 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4ADOnZQ020597
	for <linuxppc-dev@ozlabs.org>; Sat, 10 May 2008 09:24:49 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4ADOmox083514
	for <linuxppc-dev@ozlabs.org>; Sat, 10 May 2008 09:24:48 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4ADOmeI001125
	for <linuxppc-dev@ozlabs.org>; Sat, 10 May 2008 09:24:48 -0400
Date: Sat, 10 May 2008 08:22:46 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Meelis Roos <mroos@linux.ee>
Subject: Re: ppc compile failure (__flush_icache_range etc undeclared)
Message-ID: <20080510082246.0ce82981@zod.rchland.ibm.com>
In-Reply-To: <Pine.SOC.4.64.0805101448580.8450@math.ut.ee>
References: <Pine.SOC.4.64.0805101448580.8450@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 10 May 2008 14:51:27 +0300 (EEST)
Meelis Roos <mroos@linux.ee> wrote:

> Tried 2.6.26-rc1+git on ppc (arch/ppc, PReP subarch) and got this:

Segher sent patches to fix this earlier this week.  You can find them
here:

http://patchwork.ozlabs.org/linuxppc/patch?id=18348
http://patchwork.ozlabs.org/linuxppc/patch?id=18346
http://patchwork.ozlabs.org/linuxppc/patch?id=18347

People keep breaking arch/ppc and it seems there's little motivation to
fix it since it's going away in a month.

josh
