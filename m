Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 61913DDE28
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 00:13:36 +1000 (EST)
In-Reply-To: <Pine.LNX.4.64.0707180934550.20961@localhost.localdomain>
References: <Pine.LNX.4.64.0707180934550.20961@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <C5BB127A-BE08-41D9-A516-2F309A1E2E52@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] PPC:  Prevent direct inclusion of <asm/rwsem.h>.
Date: Wed, 18 Jul 2007 09:14:09 -0500
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux PPC Mailing List <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 18, 2007, at 8:36 AM, Robert P. J. Day wrote:

>
> Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

Can you provide some commit description as to why we are doing this?

- k

>
> ---
>
>   not compile-tested, so if there's a flaw here somewhere, feel free
> to tweak it.
>
>  arch/ppc/syslib/ocp.c       |    2 +-
>  include/asm-powerpc/rwsem.h |    4 ++++
>  include/asm-ppc/ocp.h       |    2 +-
>  3 files changed, 6 insertions(+), 2 deletions(-)
