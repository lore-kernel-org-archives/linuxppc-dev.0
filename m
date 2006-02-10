Return-Path: <rmk+linuxppc-dev=ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[212.18.232.186])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6DFAD67B23
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Feb 2006 08:52:18 +1100 (EST)
Date: Fri, 10 Feb 2006 21:52:06 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pat Gefre <pfg@sgi.com>
Subject: Re: [CFT] Don't use ASYNC_* nor SERIAL_IO_* with serial_core
Message-ID: <20060210215206.GB30777@flint.arm.linux.org.uk>
References: <20060121211407.GA19984@dyn-67.arm.linux.org.uk>
	<20060210084445.GA1947@flint.arm.linux.org.uk>
	<200602101457.45847.pfg@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200602101457.45847.pfg@sgi.com>
Sender: Russell King <rmk@arm.linux.org.uk>
Cc: linux-mips@linux-mips.org, Linux Kernel List <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 10, 2006 at 02:57:45PM -0600, Pat Gefre wrote:
> Yeah this is something I should've fixed up... thanks
> 
> Acked-by: pfg@sgi.com

Thanks, applied.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
