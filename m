Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rtMgV5m7fzDqDy
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 22:19:50 +1000 (AEST)
Date: Mon, 18 Jul 2016 22:19:49 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Kees Cook <keescook@google.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org,
 linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Christophe Leroy
 <christophe.leroy@c-s.fr>, "oss@buserror.net" <oss@buserror.net>
Subject: Re: linux-next: manual merge of the kspp tree with the powerpc tree
Message-ID: <20160718221949.620fba2c@canb.auug.org.au>
In-Reply-To: <871t2rb496.fsf@@concordia.ellerman.id.au>
References: <20160718130315.314f8a77@canb.auug.org.au>
 <871t2rb496.fsf@@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On Mon, 18 Jul 2016 21:00:05 +1000 Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Stephen Rothwell <sfr@canb.auug.org.au> writes:
> 
> > from the powerpc tree and commit:  
> 
> Actually that's in Scott's tree.

Oops, sorry.

> > Michael: time to sort these selects?  
> 
> Yeah I was thinking that the other day. Not sure when is a good time though.

Just after -rc1, before you open the powerpc tree up again so most of
the powerpc patches can be based after it.  Also a good time to update
the config files if necessary.

-- 
Cheers,
Stephen Rothwell
