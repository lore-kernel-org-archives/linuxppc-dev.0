Return-Path: <SRS0+7597d586580343d14ca3+1761+infradead.org+dwmw2@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2E6CEDDE1E
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jun 2008 16:51:55 +1000 (EST)
Subject: Re: [PATCH 6/9] powerpc: Add VSX CPU feature
From: David Woodhouse <dwmw2@infradead.org>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <20080618004734.1A41370297@localhost.localdomain>
References: <20080618004734.1A41370297@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 19 Jun 2008 07:51:48 +0100
Message-Id: <1213858308.26255.1390.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-06-18 at 10:47 +1000, Michael Neuling wrote:
>         {"ibm,vmx", 1, CPU_FTR_ALTIVEC, PPC_FEATURE_HAS_ALTIVEC},
>  #endif /* CONFIG_ALTIVEC */
> +#ifdef CONFIG_VSX
> +       {"ibm,vmx", 2, CPU_FTR_VSX, PPC_FEATURE_HAS_VSX},
> +#endif /* CONFIG_VSX */

Should that be "ibm,vsx"?

-- 
dwmw2
