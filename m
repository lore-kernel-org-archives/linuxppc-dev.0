Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1612CDE2E9
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jun 2008 06:19:32 +1000 (EST)
Message-ID: <48654974.6060200@freescale.com>
Date: Fri, 27 Jun 2008 15:11:32 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Nye Liu <nyet@mrv.com>
Subject: Re: [PATCH] POWERPC CPM: Minor cosmetic changes to udbg_putc
References: <20080627200100.GA16661@mrv.com>
In-Reply-To: <20080627200100.GA16661@mrv.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nye Liu wrote:
> udbg_putc is a *function pointer* that is initialized during
> udbg_init_cpm. It might not be initialized properly when called from
> udbg_putc_cpm(), so (recursively) call udbg_putc_cpm() directly.

ACK

> Printing an "X" on initialization is ugly. How about a "\n" instead?

D'oh, that was a debugging leftover that I missed when cleaning things 
up.  Just remove it.

-Scott
