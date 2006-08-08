Return-Path: <danny@mailmij.org>
Received: from mail.mailmij.org (mail.mailmij.org [82.93.140.149])
	by ozlabs.org (Postfix) with ESMTP id 8004267A3A
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Aug 2006 15:37:06 +1000 (EST)
Date: Tue, 8 Aug 2006 07:37:03 +0200
From: danny@mailmij.org
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] fix for firewire patch added in 2.6.17.2 that breaks
	things on ppc
Message-ID: <20060808073703.A13937@luna.ellen.dexterslabs.com>
References: <20060805151050.B24484@luna.ellen.dexterslabs.com>
	<20060807063854.B641@luna.ellen.dexterslabs.com>
	<17624.7051.905145.470927@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17624.7051.905145.470927@cargo.ozlabs.ibm.com>;
	from paulus@samba.org on Tue, Aug 08, 2006 at 03:05:15PM +1000
Cc: danny@mailmij.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 08, 2006 at 03:05:15PM +1000, Paul Mackerras wrote:
> danny@mailmij.org writes:
> 
> > -#endif
> > -
> > +#else
> >  	pci_save_state(pdev);
> > -
> > +#endif /* CONFIG_PPC_PMAC */
> 
> Shouldn't we just move the pci_save_state call up before the
> pmac_call_feature() call?
> 
I can do a rebuild tonight or so to test this. But since it was working perfectly before I did not see 
any reason to keep it. 

Danny
