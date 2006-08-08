Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17624.7051.905145.470927@cargo.ozlabs.ibm.com>
Date: Tue, 8 Aug 2006 15:05:15 +1000
From: Paul Mackerras <paulus@samba.org>
To: danny@mailmij.org
Subject: Re: [PATCH] fix for firewire patch added in 2.6.17.2 that breaks
	things on ppc
In-Reply-To: <20060807063854.B641@luna.ellen.dexterslabs.com>
References: <20060805151050.B24484@luna.ellen.dexterslabs.com>
	<20060807063854.B641@luna.ellen.dexterslabs.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

danny@mailmij.org writes:

> -#endif
> -
> +#else
>  	pci_save_state(pdev);
> -
> +#endif /* CONFIG_PPC_PMAC */

Shouldn't we just move the pci_save_state call up before the
pmac_call_feature() call?

Paul.
