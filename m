Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao07.cox.net (fed1rmmtao07.cox.net [68.230.241.32])
	by ozlabs.org (Postfix) with ESMTP id 877822BF0E
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Jan 2005 09:47:05 +1100 (EST)
Date: Tue, 11 Jan 2005 15:46:49 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: James Nelson <james4765@cwazy.co.uk>
Message-ID: <20050111224649.GO3391@smtp.west.cox.net>
References: <20050108170406.32690.36989.11853@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050108170406.32690.36989.11853@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND] [PATCH 0/7] ppc: remove cli()/sti() from arch/ppc/*
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jan 08, 2005 at 11:03:49AM -0600, James Nelson wrote:

> This series of patches is to remove the last cli()/sti() function calls in
> arch/ppc, and add spinlocks where necessary.

I'll push this to Andrew and hope they move from there, thanks.

-- 
Tom Rini
http://gate.crashing.org/~trini/
