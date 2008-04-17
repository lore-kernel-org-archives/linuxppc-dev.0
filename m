Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F2901DE39A
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 06:50:24 +1000 (EST)
Message-ID: <4807B7F7.4020209@freescale.com>
Date: Thu, 17 Apr 2008 15:49:59 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Dale Farnsworth <dale@farnsworth.org>
Subject: Re: [PATCH 2/5] [POWERPC] QE: add support for QE USB clocks routing
References: <20080417192656.GA19107@polina.dev.rtsoft.ru>	<20080417192846.GB28286@polina.dev.rtsoft.ru>
	<E1Jmb0q-0003Si-2M@xyzzy.farnsworth.org>
In-Reply-To: <E1Jmb0q-0003Si-2M@xyzzy.farnsworth.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dale Farnsworth wrote:

> I find "is_brg" much more meaningful than "clk < QE_CLK1".
> 
> Maybe the computer doesn't need it, but it's helpful to a
> reader of the code.

That's what comments are for.  I'm all for self-documenting code, but not
creating additional code to avoid comments.

-- 
Timur Tabi
Linux kernel developer at Freescale
