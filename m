Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17291.46505.133798.870847@cargo.ozlabs.ibm.com>
Date: Tue, 29 Nov 2005 12:58:01 +1100
From: Paul Mackerras <paulus@samba.org>
To: Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <438B5523.40903@shadowen.org>
References: <438B5523.40903@shadowen.org>
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@au1.ibm.com>
Subject: Re: PPC32 memory models
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andy Whitcroft writes:

> Attached is a patch to enable FLATMEM and disable SPARSEMEM for PPC32
> which seems to be the working combinations.  It may well not be what is
> intended.  But I offer it to start discussions.

Sounds right.

>  config ARCH_SPARSEMEM_DEFAULT
>  	def_bool y
> -	depends on SMP && PPC_PSERIES
> +	depends on SMP && PPC_PSERIES && NUMA

Shouldn't this depend on ARCH_SPARSEMEM_ENABLE?

Paul.
