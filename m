Return-Path: <joakim.tjernlund@transmode.se>
Received: from smtp.transmode.se (smtp.transmode.se [31.15.61.139])
 by lists.ozlabs.org (Postfix) with ESMTP id 3tCJ1k0QHMzDvR2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2016 03:34:33 +1100 (AEDT)
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "madalin.bucur@nxp.com"
 <madalin.bucur@nxp.com>
CC: "joe@perches.com" <joe@perches.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "oss@buserror.net" <oss@buserror.net>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "pebolle@tiscali.nl" <pebolle@tiscali.nl>, "ppc@mindchasers.com"
 <ppc@mindchasers.com>, "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH net-next v6 02/10] dpaa_eth: add support for DPAA Ethernet
Date: Mon, 7 Nov 2016 16:25:56 +0000
Message-ID: <1478535955.1983.118.camel@transmode.se>
References: <1478117854-8952-1-git-send-email-madalin.bucur@nxp.com>
 <1478117854-8952-3-git-send-email-madalin.bucur@nxp.com>
In-Reply-To: <1478117854-8952-3-git-send-email-madalin.bucur@nxp.com>
Content-Type: text/plain; charset="iso-8859-15"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-11-02 at 22:17 +0200, Madalin Bucur wrote:
> This introduces the Freescale Data Path Acceleration Architecture
> (DPAA) Ethernet driver (dpaa_eth) that builds upon the DPAA QMan,
> BMan, PAMU and FMan drivers to deliver Ethernet connectivity on
> the Freescale DPAA QorIQ platforms.

Nice to see DPAA support soon entering the kernel(not a day too early:)
I would like to see BQL supported from day one though, if possible.

=A0Regards
=A0 =A0 =A0 =A0 =A0 Joakim Tjernlund=
