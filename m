Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE004.bigfish.com (am1ehsobe004.messaging.microsoft.com
	[213.199.154.207])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 97462B6F76
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 23 Jul 2011 06:37:37 +1000 (EST)
Date: Fri, 22 Jul 2011 15:37:27 -0500
From: Scott Wood <scottwood@freescale.com>
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH V2 2/3] powerpc/83xx: consolidate of_platform_bus_probe
	calls
Message-ID: <20110722153727.3cf9e361@schlenkerla.am.freescale.net>
In-Reply-To: <1311364544-9413-3-git-send-email-dbaryshkov@gmail.com>
References: <1311364544-9413-1-git-send-email-dbaryshkov@gmail.com>
	<1311364544-9413-3-git-send-email-dbaryshkov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Linux PPC Development <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 22 Jul 2011 23:55:43 +0400
Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> wrote:

> 83xx board files have a lot of duplication in
> *_declare_of_platform_devices() functions. Merge that into a single
> function common to most of the boards.
> 
> The only leftover is mpc834x_itx.c board file which explicitly asks for
> fsl,pq2pro-localbus, as corresponding bindings don't provide
> "simple-bus" compatibility in localbus node.

What if simple-bus is added to that board's device tree in the future?
Won't we end up probing it twice?

-Scott
