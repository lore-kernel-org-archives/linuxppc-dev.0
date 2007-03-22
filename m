Return-Path: <domen.puncer@telargo.com>
Received: from out001.atlarge.net (out001.atlarge.net [129.41.63.69])
	by ozlabs.org (Postfix) with ESMTP id 9AF3CDDF8B
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 20:51:22 +1100 (EST)
Date: Thu, 22 Mar 2007 10:51:18 +0100
From: Domen Puncer <domen.puncer@telargo.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 4/10] Add arch/powerpc driver for UIC,
	PPC4xx interrupt controller
Message-ID: <20070322095118.GA18236@moe.telargo.com>
References: <20070322060630.GB16993@localhost.localdomain>
	<20070322092202.1299EDDF3E@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070322092202.1299EDDF3E@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 22/03/07 20:22 +1100, David Gibson wrote:
> +static int uic_set_irq_type(unsigned int virq, unsigned int flow_type)

> +	case IRQ_TYPE_LEVEL_HIGH:
> +		trigger = 0; polarity = 1;
> +		break;
> +	case IRQ_TYPE_LEVEL_LOW:
> +		trigger = 0; polarity = 1;

Is this intended to be the same?


	Domen
