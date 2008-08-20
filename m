Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 7A4DADE25A
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 16:38:51 +1000 (EST)
Date: Wed, 20 Aug 2008 16:38:50 +1000
From: Tony Breeds <tony@bakeyournoodle.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc: fix memory leaks in QE library
Message-ID: <20080820063850.GK934@bakeyournoodle.com>
References: <1219093928-5349-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1219093928-5349-1-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Aug 18, 2008 at 04:12:08PM -0500, Timur Tabi wrote:
> Fix two memory leaks in the Freescale QE library: add a missing kfree() in
> ucc_fast_init() if the ioremap() fails, and update ucc_fast_free() to call
> iounmap() on uf_regs.

It's been pointed out in
http://bugzilla.kernel.org/show_bug.cgi?id=11371
that ucc_slow suffers from the same (welll clsoe enough) 2 problems.
Care to fix them aswell?

Yours Tony

  linux.conf.au    http://www.marchsouth.org/
  Jan 19 - 24 2009 The Australian Linux Technical Conference!
