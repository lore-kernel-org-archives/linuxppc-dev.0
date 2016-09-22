Return-Path: <mmarek@suse.cz>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfx9s1B3NzDsgc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 22:48:16 +1000 (AEST)
Subject: Re: [PATCH] powerpc/64: whitelist unresolved modversions CRCs
To: Nicholas Piggin <npiggin@gmail.com>, linux-kbuild@vger.kernel.org
References: <20160914024507.8759-1-npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Stephen Rothwell <sfr@canb.auug.org.au>
From: Michal Marek <mmarek@suse.cz>
Message-ID: <92e4d1b9-0607-6523-43e0-7a5a6fc4de72@suse.cz>
Date: Thu, 22 Sep 2016 14:48:11 +0200
MIME-Version: 1.0
In-Reply-To: <20160914024507.8759-1-npiggin@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016-09-14 04:45, Nicholas Piggin wrote:
> These are a symptom of CRC generation failure in generic
> build code, and not powerpc specific.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> 
> Hi Michal,
> 
> Please merge this via your trees with Al's patches.

Done, thanks for the patch.

Michal
