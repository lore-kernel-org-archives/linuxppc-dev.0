Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2862867BEC
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Nov 2006 08:46:33 +1100 (EST)
Subject: Re: [PATCH] PowerPC: remove broken vsyscall code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
In-Reply-To: <200611062359.10404.sshtylyov@ru.mvista.com>
References: <200611062359.10404.sshtylyov@ru.mvista.com>
Content-Type: text/plain
Date: Tue, 07 Nov 2006 08:46:27 +1100
Message-Id: <1162849587.28571.356.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: johnstul@us.ibm.com, tglx@linutronix.de, greg.weeks@timesys.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-11-06 at 23:59 +0300, Sergei Shtylyov wrote:
> Remove vsyscalls that were broken by the PowerPC generic TOD patch, also
> fixing the build breakage due to its bad rebase.
> 
> The patch has been tested on PPC32 only. I had to preserve the data that
> are made visible to userland via /proc/ppc64/systemcfg on PPC64, however
> now there are only zeroes there and their affect isn't known to me...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

There is simply no way this will happen !

Ben.
