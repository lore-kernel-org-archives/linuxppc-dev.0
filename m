Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E01A2DDDFE
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 13:57:01 +1100 (EST)
Subject: Re: [PATCH 3/4] powerpc: Use common 52xx of_platform probe code
	for EFIKA
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sylvain Munaut <tnt@246tNt.com>
In-Reply-To: <45A410F0.3090503@246tNt.com>
References: <1167776995690-git-send-email-tnt@246tNt.com>
	<116777699771-git-send-email-tnt@246tNt.com>
	<11677769982640-git-send-email-tnt@246tNt.com>
	<11677769981995-git-send-email-tnt@246tNt.com>
	<17827.34251.87306.719371@cargo.ozlabs.ibm.com>
	<45A410F0.3090503@246tNt.com>
Content-Type: text/plain
Date: Thu, 11 Jan 2007 13:56:53 +1100
Message-Id: <1168484213.22458.386.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Linux PPC DEV <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-01-09 at 23:02 +0100, Sylvain Munaut wrote:
> About the serial patch :
> 
> > I didn't put this one in for 2.6.20, because it doesn't solve any
> > actual problem, and Ben H tells me it might trigger a bug in the
> > generic irq code.
> 
> The bug it triggered has been fixed eons ago (like last December 22),
> in a impressive one-liner patch that has 5 Signed-off/Acked-by ;) ...
> 
> But that code is rarely executed as it would imply the PSC can be
> unloaded ... (impossible when used as console). So later merge
> is OK.

And there is no real problem in this case for not disposing of the
mapping anyway. You'll just get the same mapping again when you reload
it.

Ben.
