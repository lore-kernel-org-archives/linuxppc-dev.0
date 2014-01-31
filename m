Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DC6092C00B3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 23:29:32 +1100 (EST)
Message-ID: <1391171361.27142.6.camel@pasglop>
Subject: Re: [PATCH 0/2] Fixes for PCI-E link speed
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kleber Sacilotto de Souza <klebers@linux.vnet.ibm.com>
Date: Fri, 31 Jan 2014 23:29:21 +1100
In-Reply-To: <52EB94F6.6000800@linux.vnet.ibm.com>
References: <1389967012-7774-1-git-send-email-klebers@linux.vnet.ibm.com>
 <52EB94F6.6000800@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Brian King <brking@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-01-31 at 10:20 -0200, Kleber Sacilotto de Souza wrote:
> On 01/17/2014 11:56 AM, Kleber Sacilotto de Souza wrote:
> > These two patches fix problems on the PCI-E link speed detection.
> > The first one fixes a regression and adds some improvements on the
> > code, and the second one adds definitions for Gen3 speeds.
> >
> > Kleber Sacilotto de Souza (2):
> >    powerpc/pseries: fix regression on PCI link speed
> >    powerpc/pseries: add Gen3 definitions for PCIE link speed
> >
> >   arch/powerpc/platforms/pseries/pci.c |   22 +++++++++++++++-------
> >   1 files changed, 15 insertions(+), 7 deletions(-)
> >
> 
> Hi,
> 
> Any feedback on this patch series?

Patches on this list are tracked in patchwork so are generally not
"lost". Plus I was on vacation last week. So there's no need for such
pings unless much more time has elapsed. I'll probably put it in after
-rc1.

Ben.
