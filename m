Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5EC442C02A8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2013 19:33:32 +1000 (EST)
Message-ID: <1373448801.19894.17.camel@pasglop>
Subject: Re: [RFC 2/2] powerpc/cputable: add wait feature for CPU kernel
 features
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wang Dongsheng-B40534 <B40534@freescale.com>
Date: Wed, 10 Jul 2013 19:33:21 +1000
In-Reply-To: <ABB05CD9C9F68C46A5CEDC7F15439259FBEBFC@039-SN2MPN1-022.039d.mgd.msft.net>
References: <1373444876-7783-1-git-send-email-dongsheng.wang@freescale.com>
 <1373444876-7783-2-git-send-email-dongsheng.wang@freescale.com>
 <1373448151.19894.16.camel@pasglop>
 <ABB05CD9C9F68C46A5CEDC7F15439259FBEBFC@039-SN2MPN1-022.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Li Yang-R58472 <r58472@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Zhao Chenhui-B35336 <B35336@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-07-10 at 09:29 +0000, Wang Dongsheng-B40534 wrote:
> > 
> Yes, the wait instructions is for cpu idle, It will be make cpu into
> low power mode, like DOZE & NAP. Each thread have this.

I don't need you to tell me by email, I need you to put a proper
comment in the patch submission so it ends up in the repository
and if possible a bit more detailed than that.

Ben.
