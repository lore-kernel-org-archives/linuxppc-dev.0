Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zxgT3zL2zF0dd
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 00:11:17 +1000 (AEST)
In-Reply-To: <20180528131914.32231-1-msuchanek@suse.de>
To: Michal Suchanek <msuchanek@suse.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michal Suchanek <msuchanek@suse.de>,
 Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Neuling <mikey@neuling.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/64s: Enhance the information in cpu_show_spectre_v1()
Message-Id: <40zxgS4kkwz9s5R@ozlabs.org>
Date: Tue,  5 Jun 2018 00:11:08 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-05-28 at 13:19:14 UTC, Michal Suchanek wrote:
> We now have barrier_nospec as mitigation so print it in
> cpu_show_spectre_v1 when enabled.
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a377514519b9a20fa1ea9adddbb412

cheers
