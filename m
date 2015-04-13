Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D08081A0176
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2015 11:03:18 +1000 (AEST)
Message-ID: <1428886998.9400.2.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/pasemi: Only the build the pasemi MSI code for
 PASEMI=y
From: Michael Ellerman <mpe@ellerman.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Date: Mon, 13 Apr 2015 11:03:18 +1000
In-Reply-To: <20150412190409.GA16978@gate.crashing.org>
References: <1428630726-12905-1-git-send-email-mpe@ellerman.id.au>
 <20150410142414.0ea55c4b@canb.auug.org.au>
 <1428643714.30592.4.camel@ellerman.id.au>
 <20150410164208.1cc2a994@canb.auug.org.au>
 <1428662335.21137.1.camel@ellerman.id.au>
 <20150412190409.GA16978@gate.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Olof Johannsson <olof@lixom.net>, Stephen Rothwell <sfr@canb.auug.org.au>,
 linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2015-04-12 at 14:04 -0500, Segher Boessenkool wrote:
> On Fri, Apr 10, 2015 at 08:38:55PM +1000, Michael Ellerman wrote:
> > BUT, I can't work out how to tell git-send-email I *always* want to pass -M, so
> > I'll probably forget next time :)
> 
> In your config:
> 
> --
> [diff]
> 	renames = true
> --
> 
> but this will do it for all diffs, not just for format-patch.

Ah thanks. That's probably good enough for me. If folks need a patch(1) diff
they can ask for it.

cheers
