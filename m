Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17690.7311.157219.154172@cargo.ozlabs.ibm.com>
Date: Wed, 27 Sep 2006 16:39:11 +1000
From: Paul Mackerras <paulus@samba.org>
To: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH 10/11] Add MPC8360EMDS board support
In-Reply-To: <45128378.7090508@freescale.com>
References: <45128378.7090508@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Li Yang writes:

> +#define BCSR_PHYS_ADDR		((uint)0xf8000000)
> +#define BCSR_SIZE		((uint)(32 * 1024))

This sort of thing should really be in the device tree.

Paul.
