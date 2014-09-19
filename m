Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 by lists.ozlabs.org (Postfix) with ESMTP id AABB21A0500
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Sep 2014 01:19:14 +1000 (EST)
In-Reply-To: <20140919135756.A060D1AB26D@localhost.localdomain>
References: <20140919135756.A060D1AB26D@localhost.localdomain>
To: Christophe Leroy <christophe.leroy@c-s.fr>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] powerpc32: add support for csum_add()
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Message-ID: <OF690C56D2.618CBADE-ONC1257D58.00535C2F-C1257D58.005426A0@transmode.se>
Date: Fri, 19 Sep 2014 17:19:08 +0200
Content-Type: text/plain; charset="US-ASCII"
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe Leroy <christophe.leroy@c-s.fr> wrote on 2014/09/19 15:57:56:
> Subject: [PATCH 2/2] powerpc32: add support for csum_add()
> 
> The C version of csum_add() as defined in include/net/checksum.h gives 
the
> following assembly:
>        0:       7c 04 1a 14     add     r0,r4,r3
>        4:       7c 64 00 10     subfc   r3,r4,r0
>        8:       7c 63 19 10     subfe   r3,r3,r3
>        c:       7c 63 00 50     subf    r3,r3,r0
> 
> include/net/checksum.h also offers the possibility to define an arch 
specific
> function.
> This patch provides a ppc32 specific csum_add() inline function.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 
> ---

Ouch, this is still so. Back in 2010 I reported this to gcc:
  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=43892

Anyway, 
        Acked-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
