Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao09.cox.net (fed1rmmtao09.cox.net [68.230.241.30])
	by ozlabs.org (Postfix) with ESMTP id A94D967A6B
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Feb 2005 03:54:30 +1100 (EST)
Date: Sun, 6 Feb 2005 09:54:28 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Message-ID: <20050206165428.GA7686@smtp.west.cox.net>
References: <20050206125056.GA6394@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050206125056.GA6394@suse.de>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] remove .tmp_gas_check
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Feb 06, 2005 at 01:50:56PM +0100, Olaf Hering wrote:

> make ARCH=ppc tags leaves a .tmp_gas_check file behind.
> Just remove it after the as test.
> 
> Signed-off-by: Olaf Hering <olh@suse.de>

What is the problem exactly?  .tmp_* should be removed in a normal
'clean' target ?

-- 
Tom Rini
http://gate.crashing.org/~trini/
