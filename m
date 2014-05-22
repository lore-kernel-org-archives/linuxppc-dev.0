Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7512F1A0088
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 May 2014 23:17:23 +1000 (EST)
Message-ID: <1400764635.29150.35.camel@pasglop>
Subject: Re: powerpc: CONFIG_WSP_DD1_WORKAROUND_DD1_TCE_BUGS?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Bolle <pebolle@tiscali.nl>
Date: Thu, 22 May 2014 23:17:15 +1000
In-Reply-To: <1400749765.16832.18.camel@x220>
References: <1400749765.16832.18.camel@x220>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-05-22 at 11:09 +0200, Paul Bolle wrote:
> In v3.2 checks for CONFIG_WSP_DD1_WORKAROUND_DD1_TCE_BUGS and
> CONFIG_WSP_DD1_WORKAROUND_BAD_PCIE_CLASS were added to
> arch/powerpc/platforms/wsp/wsp_pci.c. The check for
> CONFIG_WSP_DD1_WORKAROUND_BAD_PCIE_CLASS was dropped again in v3.3.
> 
> Neither of these macros have ever had a matching Kconfig symbol. So they
> have always evaluated to false.
> 
> Is it perhaps intended that one sets the macro still in the tree,
> CONFIG_WSP_DD1_WORKAROUND_DD1_TCE_BUGS, manually? And is that macro
> still needed?

To be honest we can kill all of the wsp code I think ... The project
got canned and I don't think anybody still uses them.

Cheers,
Ben.
