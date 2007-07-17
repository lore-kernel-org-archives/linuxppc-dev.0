Return-Path: <vitb@kernel.crashing.org>
Received: from vitb.dev.rtsoft.ru (unknown [85.21.88.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D7545DDE43
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 03:50:43 +1000 (EST)
Date: Tue, 17 Jul 2007 21:50:45 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] POWERPC: add support of the GiGE switch for mpc8313RDB
	via fixed PHY
Message-ID: <20070717215045.69fa9de6@vitb.ru.mvista.com>
In-Reply-To: <20070717164331.GC7347@ld0162-tx32.am.freescale.net>
References: <20070717004936.21700.67900.stgit@localhost.localdomain>
	<20070717164331.GC7347@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 17 Jul 2007 11:43:31 -0500
Scott Wood <scottwood@freescale.com> wrote:

> This just comments on code style, not semantics...  I agree with Segher
> that this isn't the way to do it.

That's nm, I'll rather include specific field into mac node,
so the function below will be rewritten.

-- 
Sincerely, 
Vitaly
