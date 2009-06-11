Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6B7E1B71ED
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 13:41:17 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2757DDDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 13:41:15 +1000 (EST)
Message-Id: <1A5D98E1-9A5A-4A4E-AA02-BB999CDC559C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Dave Liu <daveliu@freescale.com>
In-Reply-To: <1244471076-25905-1-git-send-email-daveliu@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH] serial: Fix bug of ucc_uart
Date: Wed, 10 Jun 2009 22:39:08 -0500
References: <1244471076-25905-1-git-send-email-daveliu@freescale.com>
Cc: linuxppc-dev@ozlabs.org, timur@freescale.com, linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 8, 2009, at 9:24 AM, Dave Liu wrote:

> Current ucc_uart driver doesn't work at UART mode,
> The TxBD[READY] is not cleared by H/W (RISC engine)
> when user send characters to Tx buffer of QE UART.
> so, these characters stay on the QE forever, never
> go to UART line.
>
> The patch is fixing th bug.
>
> Signed-off-by: Dave Liu <daveliu@freescale.com>
> ---
> drivers/serial/ucc_uart.c |   19 ++++++++++++++-----
> 1 files changed, 14 insertions(+), 5 deletions(-)

applied to next.

(Cleaned up the commit message a bit)

- k
