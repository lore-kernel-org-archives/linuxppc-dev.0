Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by lists.ozlabs.org (Postfix) with ESMTP id E671C1A0211
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 02:40:35 +1000 (AEST)
Date: Tue, 28 Apr 2015 13:40:30 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 0/7] Fixes for perf probe issues on ppc
Message-ID: <20150428164030.GA27827@kernel.org>
References: <cover.1430217967.git.naveen.n.rao@linux.vnet.ibm.com>
 <20150428135453.GL16849@kernel.org>
 <20150428161217.GA31661@naverao1-tp.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150428161217.GA31661@naverao1-tp.ibm.com>
Cc: linux-kernel@vger.kernel.org, masami.hiramatsu.pt@hitachi.com,
 sukadev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 srikar@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Tue, Apr 28, 2015 at 09:42:17PM +0530, Naveen N. Rao escreveu:
> On 2015/04/28 10:54AM, Arnaldo Carvalho de Melo wrote:
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
> 
> Sure. We will wait for Masami and Srikar to review/confirm, but Srikar's 
> reviewed-by is for the current revision.

Well, then I can go ahead and push it, later today, as I have applied
all of the patches that Srikar has reviewed, the one I'm waiting for
Masami can go when he reacts.

- Arnaldo
