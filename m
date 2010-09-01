Return-Path: <timur.tabi@gmail.com>
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <1283269738-14612-2-git-send-email-julia@diku.dk>
References: <1283269738-14612-1-git-send-email-julia@diku.dk>
	<1283269738-14612-2-git-send-email-julia@diku.dk>
From: Timur Tabi <timur@freescale.com>
Date: Wed, 1 Sep 2010 13:40:05 -0500
Message-ID: <AANLkTikDfFkwKMmn8d1pqUrn+=KL4YH_PE3uXehq-6FG@mail.gmail.com>
Subject: Re: [PATCH 1/4] drivers/serial/ucc_uart.c: Add of_node_put to avoid
	memory leak
To: Julia Lawall <julia@diku.dk>
Content-Type: text/plain; charset=ISO-8859-1
Cc: kernel-janitors@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 31, 2010 at 10:48 AM, Julia Lawall <julia@diku.dk> wrote:
> Add a call to of_node_put in the error handling code following a call to
> of_find_compatible_node or of_find_node_by_type.
>
> This patch also substantially reorganizes the error handling code in the
> function, to that it is possible first to jump to code that frees qe_port
> and then to jump to code that also puts np.

Acked-by: Timur Tabi <timur@freescale.com>

Thanks, Julia.

-- 
Timur Tabi
Linux kernel developer at Freescale
