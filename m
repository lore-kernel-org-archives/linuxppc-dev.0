Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id AC3F4DDF6C
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 04:58:59 +1000 (EST)
Date: Sun, 20 Jul 2008 14:58:58 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Don't panic when EEH_MAX_FAILS is exceeded
Message-ID: <20080720145858.5be92934@lappy.seanm.ca>
In-Reply-To: <488383D4.9000602@us.ibm.com>
References: <488383D4.9000602@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 20 Jul 2008 11:28:36 -0700
"Mike Mason" <mmlnx@us.ibm.com> wrote:

> This patch changes the EEH_MAX_FAILS action from panic to printing an
> error message.  Panicking under under this condition is too harsh.
> Although performance will be affected and the device may not recover,
> the system is still running, which at the very least, should allow
> for a more graceful shutdown.  The panic() is now wrapped in a DEBUG
> statement for development purposes.  The patch also removes the
> msleep() within a spinlock, which is not allowed.

Why can you not msleep within a spinlock? And when was this change
brought in?

Cheers,
   Sean
