Return-Path: <rmk+linuxppc-dev=ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[212.18.232.186])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1925D689C0
	for <linuxppc-dev@ozlabs.org>; Sun,  5 Feb 2006 11:01:50 +1100 (EST)
Date: Sun, 5 Feb 2006 00:01:36 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Hirokazu Takata <takata@linux-m32r.org>
Subject: Re: [CFT] Don't use ASYNC_* nor SERIAL_IO_* with serial_core
Message-ID: <20060205000136.GF24887@flint.arm.linux.org.uk>
References: <20060121211407.GA19984@dyn-67.arm.linux.org.uk>
	<20060202102721.GE5034@flint.arm.linux.org.uk>
	<20060202.231033.1059963967.takata.hirokazu@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060202.231033.1059963967.takata.hirokazu@renesas.com>
Sender: Russell King <rmk@arm.linux.org.uk>
Cc: pfg@sgi.com, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 02, 2006 at 11:10:33PM +0900, Hirokazu Takata wrote:
> On m32r,
>   compile and boot test: OK

Is that an Acked-by ?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
