Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CCDFEDDED4
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 11:34:44 +1100 (EST)
Message-Id: <1688882F-33D3-4A0B-B16E-5824C8333B6E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Li Yang <leoli@freescale.com>
In-Reply-To: <1192793930-26039-5-git-send-email-leoli@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH v7 4/9] add platform support for MPC837x MDS board
Date: Thu, 29 Nov 2007 18:34:36 -0600
References: <1192793930-26039-1-git-send-email-leoli@freescale.com>
	<1192793930-26039-2-git-send-email-leoli@freescale.com>
	<1192793930-26039-3-git-send-email-leoli@freescale.com>
	<1192793930-26039-4-git-send-email-leoli@freescale.com>
	<1192793930-26039-5-git-send-email-leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 19, 2007, at 6:38 AM, Li Yang wrote:

> The MPC837x MDS is a new member of Freescale MDS reference system.
>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> arch/powerpc/platforms/83xx/Kconfig       |   12 +++
> arch/powerpc/platforms/83xx/Makefile      |    1 +
> arch/powerpc/platforms/83xx/mpc837x_mds.c |  104 ++++++++++++++++++++ 
> +++++++++
> 3 files changed, 117 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/platforms/83xx/mpc837x_mds.c


applied.

- k
