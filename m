Return-Path: <SRS0+4f1e0d28af8560107a14+1293+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2ED7EDDEA0
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Mar 2007 11:18:59 +1100 (EST)
Subject: Re: [PATCH] Complain about missing system calls.
From: David Woodhouse <dwmw2@infradead.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20070308.161407.63995586.davem@davemloft.net>
References: <1173394873.3461.510.camel@pmac.infradead.org>
	<20070308.161407.63995586.davem@davemloft.net>
Content-Type: text/plain
Date: Fri, 09 Mar 2007 00:18:49 +0000
Message-Id: <1173399529.3461.542.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, sam@ravnborg.org,
	linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-03-08 at 16:14 -0800, David Miller wrote:
> The rest, like ioperm, iopl, modify_ldt, et al. are i386
> specific.

Thanks for the update. Quite why the PowerPC kernel defines system call
numbers for all of these I have no idea :)

-- 
dwmw2
