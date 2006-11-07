Return-Path: <tnt@246tNt.com>
Message-ID: <455063C6.6070205@246tNt.com>
Date: Tue, 07 Nov 2006 11:45:26 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Nicolas DET <nd@bplan-gmbh.de>
Subject: Re: [PATCH/RFC] powerpc: Add MPC5200 Interrupt Controller support.
References: <200611071040.kA7Aeea6006482@post.webmailer.de>
In-Reply-To: <200611071040.kA7Aeea6006482@post.webmailer.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, sven@genesi-usa.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nicolas DET wrote:

> This patch add MPC52xx Interrupt controller for ARCH=powerpc.
>
> It includes the main code in arch/powerpc/sysdev/ ad well as an header file in
> include/asm-powerpc.
>
> The header file has now distinct section for the struct and the IRQ mapping/enconding define
>
> Signed-off-by: Nicolas DET <nd@bplan-gmbh.de>
Acked-by: Sylvain Munaut <tnt@246tNt.com>
