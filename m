Return-Path: <glikely@secretlab.ca>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.238])
	by ozlabs.org (Postfix) with ESMTP id 9A0C4DDF16
	for <linuxppc-dev@ozlabs.org>; Sun, 29 Jun 2008 15:58:28 +1000 (EST)
Received: by qb-out-0506.google.com with SMTP id d8so2685227qbc.37
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jun 2008 22:58:27 -0700 (PDT)
Date: Sat, 28 Jun 2008 23:58:25 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: John Rigby <jrigby@freescale.com>
Subject: Re: [PATCH 1/2] powerpc: pci config cleanup [rev2]
Message-ID: <20080629055825.GI13876@secretlab.ca>
References: <1214500077-9254-1-git-send-email-jrigby@freescale.com>
	<1214500077-9254-2-git-send-email-jrigby@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1214500077-9254-2-git-send-email-jrigby@freescale.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 26, 2008 at 11:07:56AM -0600, John Rigby wrote:
> Choosing PCI or not at config time is allowed on some
> platforms via an if expression in arch/powerpc/Kconfig.
> To add a new platform with PCI support selectable at
> config time, you must change the if expression.  This
> patch makes this easier by changing:
>     bool "PCI support" if <long expression>
> to
>     bool "PCI support" if PPC_PCI_CHOICE
> and adding select PPC_PCI_CHOICE to all the config nodes that
> were previously in the PCI if expression.
> 
> Platforms with unconditional PCI support continue to
> just select PCI in their config nodes.
> 
> Signed-off-by: John Rigby <jrigby@freescale.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>
