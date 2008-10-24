Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 937ECDDE0A
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Oct 2008 10:48:28 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id m9ONm9Jt032149
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Oct 2008 17:48:09 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m9ONmPtD107262
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Oct 2008 17:48:25 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m9ONmPSU018093
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Oct 2008 17:48:25 -0600
Date: Fri, 24 Oct 2008 19:48:22 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Niklaus Giger <niklaus.giger@member.fsf.org>
Subject: Re: [PATCH] powerpc/40x: Don't enable HCU4 board by default
Message-ID: <20081024194822.64f9551d@zod.rchland.ibm.com>
In-Reply-To: <200810242354.24984.niklaus.giger@member.fsf.org>
References: <20081024143158.GA13766@yoda.jdub.homelinux.org>
	<200810242354.24984.niklaus.giger@member.fsf.org>
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

On Fri, 24 Oct 2008 23:54:24 +0200
Niklaus Giger <niklaus.giger@member.fsf.org> wrote:

> Am Freitag 24 Oktober 2008 16.31:58 schrieb Josh Boyer:
> > Fix the HCU4 Kconfig option to 'default n'.  We don't want the
> > board to always be enabled for other board defconfigs.
> Sorry, for this silly mistake. Thanks for your fix.

You don't need to apologize.  Have you noticed that I have "fixed" the
EMAC driver 3 times this merge window already, all for my own stupid
mistakes? :)

> My board compiles and runs fine using Linus 2.6.28-rc1.

Thanks for testing!

josh
