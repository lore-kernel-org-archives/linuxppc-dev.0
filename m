Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 39168DDED7
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 03:46:49 +1100 (EST)
Message-Id: <18D6DC29-CCBB-4221-A0B2-64D0555EB8E2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Xiaotian Feng <Xiaotian.Feng@windriver.com>
In-Reply-To: <1236308483-20495-1-git-send-email-Xiaotian.Feng@windriver.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] cpm_uart: fix non-console port startup bug
Date: Mon, 9 Mar 2009 11:46:41 -0500
References: <1236308483-20495-1-git-send-email-Xiaotian.Feng@windriver.com>
Cc: linuxppc-dev@ozlabs.org, panto@intracom.gr, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 5, 2009, at 9:01 PM, Xiaotian Feng wrote:

>  After UART interrupt handler is installed and rx is enabled, if an rx
> interrupt comes before hardware init, rx->cur will be updated. Then  
> the
> hardware init will reset BD and make rx->cur out of sync, move the  
> hardware
> init code before request_irq.
>
>  Signed-off-by: Xiaotian Feng <xiaotian.feng@windriver.com>
> ---
> drivers/serial/cpm_uart/cpm_uart_core.c |   14 ++++++++++++--
> 1 files changed, 12 insertions(+), 2 deletions(-)

applied to next

- k
