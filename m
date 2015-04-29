Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by lists.ozlabs.org (Postfix) with ESMTP id 4CF0D1A00CA
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 May 2015 06:55:01 +1000 (AEST)
Date: Wed, 29 Apr 2015 19:09:19 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 0/7] Fixes for perf probe issues on ppc
Message-ID: <20150429220919.GC29633@kernel.org>
References: <cover.1430217967.git.naveen.n.rao@linux.vnet.ibm.com>
 <20150428135453.GL16849@kernel.org>
 <20150429053758.GA17469@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150429053758.GA17469@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, masami.hiramatsu.pt@hitachi.com,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, sukadev@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Wed, Apr 29, 2015 at 11:07:58AM +0530, Srikar Dronamraju escreveu:
> * Arnaldo Carvalho de Melo <acme@kernel.org> [2015-04-28 10:54:53]:
> 
> > Em Tue, Apr 28, 2015 at 05:35:33PM +0530, Naveen N. Rao escreveu:
> > > This patchset fixes various issues with perf probe on powerpc across ABIv1 and
> > > ABIv2:
> > > - in the presence of DWARF debug-info,
> > > - in the absence of DWARF, but with the symbol table, and
> > > - in the absence of debug-info, but with kallsyms.
> > > 
> > > Arnaldo,
> > > I have moved all patches to use __weak functions. Kindly take a look and let me
> > > know if this is what you had in mind.
> > 
> > Ok, I applied all but the first, for which I am waiting for Masami's
> > reaction, I kept Srikar's reviewed-by for the other patches, but would
> > as well like to get his word that he keeps it after the __weak changes.
> > 
> > So, for now, I'll leave it for a while sitting in my local tree, to give
> > time to Masami and Srikar, ok?
> > 
> 
> Yes Arnaldo, I have looked at the patches after the __weak changes and
> they look good to me.

Thanks everybody, I got it merged on my perf/core branch, that I'll
submit as soon as I see an Ingo :-)

- Arnaldo
