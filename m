Return-Path: <takata@linux-m32r.org>
Received: from mail04.idc.renesas.com (mail.renesas.com [202.234.163.13])
	by ozlabs.org (Postfix) with ESMTP id 6752868A0F
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Feb 2006 12:34:49 +1100 (EST)
Received: from mail04.idc.renesas.com ([127.0.0.1])
	by mail04.idc.renesas.com. (SMSSMTP 4.1.9.35) with SMTP id
	M2006020610344704681
	for <linuxppc-dev@ozlabs.org>; Mon, 06 Feb 2006 10:34:47 +0900
Date: Mon, 06 Feb 2006 10:34:43 +0900 (JST)
Message-Id: <20060206.103443.608416320.takata.hirokazu@renesas.com>
To: rmk+lkml@arm.linux.org.uk
Subject: Re: [CFT] Don't use ASYNC_* nor SERIAL_IO_* with serial_core
From: Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <20060205000136.GF24887@flint.arm.linux.org.uk>
References: <20060202102721.GE5034@flint.arm.linux.org.uk>
	<20060202.231033.1059963967.takata.hirokazu@renesas.com>
	<20060205000136.GF24887@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: pfg@sgi.com, linux-mips@linux-mips.org, takata@linux-m32r.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [CFT] Don't use ASYNC_* nor SERIAL_IO_* with serial_core
Date: Sun, 05 Feb 2006 00:01:36 +0000
> On Thu, Feb 02, 2006 at 11:10:33PM +0900, Hirokazu Takata wrote:
> > On m32r,
> >   compile and boot test: OK
> 
> Is that an Acked-by ?
> 
> -- 
> Russell King
>  Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
>  maintainer of:  2.6 Serial core
> 

Yes.

Acked-by: Hirokazu Takata <takata@linux-m32r.org>

Thanks,
--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
