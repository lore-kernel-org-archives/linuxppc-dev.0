Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EC5A11A02DE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2016 01:27:06 +1100 (AEDT)
Message-ID: <1453904822.27129.44.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Alessio Igor Bogani <alessio.bogani@elettra.eu>, Kumar Gala
 <galak@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Wed, 27 Jan 2016 08:27:02 -0600
In-Reply-To: <1453904726.27129.42.camel@buserror.net>
References: <CAPk1OjGew2n-17ztcbxcxBXWundeEk5nKQ5MS1HLYR4fiBOjxg@mail.gmail.com>
 <1453904726.27129.42.camel@buserror.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: Question about 86xx
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-01-27 at 08:25 -0600, Scott Wood wrote:
> On Wed, 2016-01-27 at 10:24 +0100, Alessio Igor Bogani wrote:
> > Hi Kumar,
> > 
> > I'm wondering if we are allowed to put together configurations of the
> > 86xx base systems (gef_ppc9a_defconfig, gef_sbc310_defconfig,
> > gef_sbc610_defconfig, mpc8610_hpcd_defconfig, mpc8641_hpcn_defconfig
> > and sbc8641d_defconfig) into the
> > mpc86xx_defconfig/mpc86xx_smp_defconfig as like already done for 85xx
> > ones.
> > 
> > Thank you very much!
> 
> Yes, that would be good.

Also consider using config fragments like 85xx now does (and sharing fragments
with 85xx where appropriate).

-Scott
