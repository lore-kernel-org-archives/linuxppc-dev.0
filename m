Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao04.cox.net (fed1rmmtao04.cox.net [68.230.241.35])
	by ozlabs.org (Postfix) with ESMTP id 1A8762BDB5
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Dec 2004 08:04:35 +1100 (EST)
Date: Tue, 30 Nov 2004 14:04:31 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andy Fleming <afleming@freescale.com>
Message-ID: <20041130210431.GJ9894@smtp.west.cox.net>
References: <F9AAB23C-4254-11D9-A096-000393C30512@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <F9AAB23C-4254-11D9-A096-000393C30512@freescale.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] Remove 604 perfmon from ppc_htab
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Nov 29, 2004 at 04:21:11PM -0600, Andy Fleming wrote:

> This patch removes the 604 performance monitor counters from ppc_htab.  
> The reason is that people have said that no one uses them, and ppc_htab 
> is not the right place for them.  Any objections?

Is all of this properly hooked into oprofile(/is perfmon in -Linus now?)
etc now?  If so, this sounds like a fine thing to get into 2.6.11.

-- 
Tom Rini
http://gate.crashing.org/~trini/
