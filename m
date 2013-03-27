Return-Path: <pebolle@tiscali.nl>
Received: from cpsmtpb-ews02.kpnxchange.com (cpsmtpb-ews02.kpnxchange.com
 [213.75.39.5]) by ozlabs.org (Postfix) with ESMTP id 4B7D52C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2013 21:51:41 +1100 (EST)
Message-ID: <1364381495.1345.21.camel@x61.thuisdomein>
Subject: Re: [PATCH] powerpc: drop even more unused Kconfig symbols
From: Paul Bolle <pebolle@tiscali.nl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 27 Mar 2013 11:51:35 +0100
In-Reply-To: <1363864206.1390.117.camel@x61.thuisdomein>
References: <1363864206.1390.117.camel@x61.thuisdomein>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-03-21 at 12:10 +0100, Paul Bolle wrote:
> diff --git a/arch/powerpc/platforms/wsp/Kconfig b/arch/powerpc/platforms/wsp/Kconfig
> index 79d2225..9eea710 100644
> --- a/arch/powerpc/platforms/wsp/Kconfig
> +++ b/arch/powerpc/platforms/wsp/Kconfig
> @@ -29,7 +29,3 @@ config PPC_CHROMA
>  	default y
>  
>  endmenu
> -
> -config PPC_A2_DD2
> -	bool "Support for DD2 based A2/WSP systems"
> -	depends on PPC_A2

This part was not included in the "powerpc: remove PReP" follow up
patch. Should I resend separately?


Paul Bolle
