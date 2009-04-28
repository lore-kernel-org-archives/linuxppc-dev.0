Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 08D77DDEE3
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2009 04:06:12 +1000 (EST)
Date: Tue, 28 Apr 2009 11:01:51 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] of: make of_(un)register_platform_driver common code.
Message-Id: <20090428110151.9fc6ee3f.akpm@linux-foundation.org>
In-Reply-To: <20090428135821.8530.85153.stgit@localhost.localdomain>
References: <20090428135821.8530.85153.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: monstr@monstr.eu, linuxppc-dev@ozlabs.org, rpurdie@linux.intel.com,
	smaclennan@pikatech.com, sparclinux@vger.kernel.org,
	davem@davemloft.net, john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 28 Apr 2009 07:58:26 -0600
Grant Likely <grant.likely@secretlab.ca> wrote:

> Some drivers using of_register_platform_driver() wrapper break on sparc
> because the wrapper isn't in the header file.  This patch moves it from
> Microblaze and PowerPC implementations and makes it common code.

Thanks.  I'll plan to merge this into mainline later in the week.
