Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E5546B70B0
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Dec 2010 06:40:07 +1100 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e31.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id oB3JQUuY011707
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Dec 2010 12:26:30 -0700
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id oB3JdnTW147104
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Dec 2010 12:39:52 -0700
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id oB3JdmYO020943
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Dec 2010 12:39:49 -0700
Date: Fri, 3 Dec 2010 14:39:01 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] watchdog: add CONFIG_WATCHDOG_NOWAYOUT support to
	PowerPC Book-E watchdog driver
Message-ID: <20101203193900.GC1903@zod.rchland.ibm.com>
References: <1291395103-12394-1-git-send-email-timur@freescale.com>
	<20101203180751.GA1903@zod.rchland.ibm.com>
	<4CF93566.1050601@freescale.com>
	<20101203190556.GB1903@zod.rchland.ibm.com>
	<4CF9408A.4030506@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4CF9408A.4030506@freescale.com>
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com,
	linux-watchdog@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 03, 2010 at 01:10:02PM -0600, Timur Tabi wrote:
>> I guess I don't really care either way if multiple processes have the
>> device open, as long as none of them can "disable" the watchdog if
>> NOWAYOUT is set.
>
>Well, this patch takes care of that problem.
>
>So just to be clear, do you still have any issues with my patch?

Just the moving of the clear_bit inside the #ifndef
CONFIG_WATCHDOG_NOWAYOUT.

josh
