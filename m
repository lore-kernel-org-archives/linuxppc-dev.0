Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 3BB50DDF58
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2007 08:30:57 +1000 (EST)
Date: Tue, 10 Apr 2007 17:48:09 -0500
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH 1/4] powerpc: document max-speed and interface-type
	properties
Message-ID: <20070410224809.GA20848@lixom.net>
References: <20070410165639.1b619c34.kim.phillips@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070410165639.1b619c34.kim.phillips@freescale.com>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 10, 2007 at 04:56:39PM -0500, Kim Phillips wrote:
> Since ucc_geth is being migrated to use the phylib, the existing
> (undocumented) 'interface' property is being deprecated in favour
> of unconjoined variations 'max-speed' and 'interface-type'.
> 
> max-speed is necessary for QE UEC devices that do not make that
> information available through their programming model.

Do you really need to set max speed for devices that are at the default
max speed for the interface type? Seems redundant.

If for example there's an rgmii interface that for some reason only can
handle 100Mbit, that'd be different.


-Olof
