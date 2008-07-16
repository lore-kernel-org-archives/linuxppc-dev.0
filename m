Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-quonix.sasl.smtp.pobox.com
	[208.72.237.25]) by ozlabs.org (Postfix) with ESMTP id C6A6EDE2D4
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 08:42:18 +1000 (EST)
Date: Wed, 16 Jul 2008 17:42:08 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] powerpc: fix support for latencytop
Message-ID: <20080716224208.GF9594@localdomain>
References: <48755237.9070701@nortel.com> <200807101608.18643.arnd@arndb.de>
	<20080716202236.GZ9594@localdomain> <200807170012.25859.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200807170012.25859.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> We need to pass the kernel stack pointer instead of the user space
> stack pointer in save_stack_trace_tsk().

Thanks, this fixes it, and latencytop even seems to work. :)
