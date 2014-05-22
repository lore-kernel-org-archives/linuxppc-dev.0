Return-Path: <pebolle@tiscali.nl>
Received: from cpsmtpb-ews05.kpnxchange.com (cpsmtpb-ews05.kpnxchange.com
 [213.75.39.8])
 by lists.ozlabs.org (Postfix) with ESMTP id 15D7D1A0592
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 May 2014 19:09:30 +1000 (EST)
Message-ID: <1400749765.16832.18.camel@x220>
Subject: powerpc: CONFIG_WSP_DD1_WORKAROUND_DD1_TCE_BUGS?
From: Paul Bolle <pebolle@tiscali.nl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>
Date: Thu, 22 May 2014 11:09:25 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In v3.2 checks for CONFIG_WSP_DD1_WORKAROUND_DD1_TCE_BUGS and
CONFIG_WSP_DD1_WORKAROUND_BAD_PCIE_CLASS were added to
arch/powerpc/platforms/wsp/wsp_pci.c. The check for
CONFIG_WSP_DD1_WORKAROUND_BAD_PCIE_CLASS was dropped again in v3.3.

Neither of these macros have ever had a matching Kconfig symbol. So they
have always evaluated to false.

Is it perhaps intended that one sets the macro still in the tree,
CONFIG_WSP_DD1_WORKAROUND_DD1_TCE_BUGS, manually? And is that macro
still needed?


Paul Bolle
