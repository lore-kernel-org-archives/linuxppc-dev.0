Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 09B08DDE3F
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Nov 2007 03:18:48 +1100 (EST)
Date: Sun, 25 Nov 2007 19:18:33 +0300
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH revised 3/4] powerpc: Add EXPORT_SYMBOL_GPL for symbols
	required by fs_enet and cpm_uart
Message-ID: <20071125191833.1e76f335@kernel.crashing.org>
In-Reply-To: <47499711.2020409@freescale.com>
References: <4745BDC9.3080602@scram.de>
	<47499711.2020409@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 25 Nov 2007 09:38:57 -0600
Timur Tabi wrote:

> Jochen Friedrich wrote:
> > fs_enet and cpm_uart need symbols from commproc.c (for CPM1) or
> > cpm2_common.c. Add EXPORT_SYMBOL_GPL for cpmp, cpm_setbrg and
> > cpm2_immr, so the drivers can be compiled as modules.
As I told replying to prev mail, this needs to be addressed in respective driver(s), since
there is a way to retrieve such pointers without making them global.

This patch will exist in maillist as a workaround, but meanwhile I'll take a look at this problem.
> 
> Maybe this is a stupid question, but why did you choose
> EXPORT_SYMBOL_GPL and not EXPORT_SYMBOL?
> 
To prevent using those pointers from within non-GPL modules. kind of policy now...

-- 
Sincerely, Vitaly
