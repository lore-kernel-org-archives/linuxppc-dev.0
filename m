Return-Path: <kumagai-atsushi@mxc.nes.nec.co.jp>
Received: from tyo200.gate.nec.co.jp (TYO200.gate.nec.co.jp [202.32.8.215])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 17A8FB6EE7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2012 22:00:18 +1100 (EST)
Received: from tyo201.gate.nec.co.jp ([10.7.69.201])
 by tyo200.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id q1KA19G4008478
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2012 19:01:09 +0900 (JST)
Date: Mon, 20 Feb 2012 18:56:01 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
To: benh@kernel.crashing.org, suzuki@in.ibm.com
Subject: Re: [PATCH v1 0/4][makedumpfile] vmalloc translation support for PPC32
Message-Id: <20120220185601.d08b8864.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <1329467969.2892.58.camel@pasglop>
References: <20120216033411.7972.77705.stgit@suzukikp>
 <20120217093220.0c2993a1.kumagai-atsushi@mxc.nes.nec.co.jp>
 <4F3DEBCF.8000201@in.ibm.com> <1329467969.2892.58.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, Benjamin
Hi, Suzuki

On Fri, 17 Feb 2012 19:39:29 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Fri, 2012-02-17 at 11:25 +0530, Suzuki K. Poulose wrote:
> > > Could you tell me what kind of data is stored in vmalloc region in
> > PPC ?
> > > I want to estimate importance of your patches for makedumpfile.
> > I know at least the modules are loaded in the vmalloc'd region. I have
> > Cc'ed linux-ppc dev. We should be able to get enough info from the
> > experts here.
> > 
> > Josh / Kumar / Others,
> > 
> > Could you please let us know your thoughts ?
> 
> Modules, driver IO mappings, etc... I can see that being useful for
> crashdumps.

Thank you for your information.

The above data may be required for one function of makedumpfile (filter
out kernel data) but not so crucial for makedumpfile as page descriptors
and related data(e.g. pglist_data).

Moreover, I'm preparing the release of v1.4.3 now, so I'll merge vmalloc
support for PPC32 into v1.4.4. Is it all right for you, Suzuki ?


Thanks
Atsushi Kumagai
