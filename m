Return-Path: <SRS0+fdd23b9c115b88e530f5+1108+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C8ABB67A3F
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Sep 2006 07:42:02 +1000 (EST)
Subject: Re: [PATCH] Unwire set/get_robust_list
From: David Woodhouse <dwmw2@infradead.org>
To: Andreas Schwab <schwab@suse.de>
In-Reply-To: <jeodtvfn4x.fsf@sykes.suse.de>
References: <jeodtvfn4x.fsf@sykes.suse.de>
Content-Type: text/plain
Date: Tue, 05 Sep 2006 14:41:57 -0700
Message-Id: <1157492517.2477.62.camel@shinybook.infradead.org>
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

On Mon, 2006-09-04 at 21:27 +0200, Andreas Schwab wrote:
> The syscalls set/get_robust_list must not be wired up until
> futex_atomic_cmpxchg_inatomic is implemented.  Otherwise the kernel
> will hang in handle_futex_death. 

Either Andreas' or my patch ought to go into 2.6.18, since
[gs]et_robust_list() are otherwise broken there.

-- 
dwmw2
