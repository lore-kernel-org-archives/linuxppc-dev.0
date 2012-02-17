Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A8D4B1007D5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2012 19:39:54 +1100 (EST)
Message-ID: <1329467969.2892.58.camel@pasglop>
Subject: Re: [PATCH v1 0/4][makedumpfile] vmalloc translation support for PPC32
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Date: Fri, 17 Feb 2012 19:39:29 +1100
In-Reply-To: <4F3DEBCF.8000201@in.ibm.com>
References: <20120216033411.7972.77705.stgit@suzukikp>
 <20120217093220.0c2993a1.kumagai-atsushi@mxc.nes.nec.co.jp>
 <4F3DEBCF.8000201@in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux ppc dev <linuxppc-dev@lists.ozlabs.org>,
 Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-02-17 at 11:25 +0530, Suzuki K. Poulose wrote:
> > Could you tell me what kind of data is stored in vmalloc region in
> PPC ?
> > I want to estimate importance of your patches for makedumpfile.
> I know at least the modules are loaded in the vmalloc'd region. I have
> Cc'ed linux-ppc dev. We should be able to get enough info from the
> experts here.
> 
> Josh / Kumar / Others,
> 
> Could you please let us know your thoughts ?

Modules, driver IO mappings, etc... I can see that being useful for
crashdumps.

Cheers,
Ben.
