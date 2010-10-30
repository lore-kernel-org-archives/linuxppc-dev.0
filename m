Return-Path: <jk@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
To: cbe-oss-dev@lists.ozlabs.org
Subject: Re: [Cbe-oss-dev] [PATCH] PowerPC/Cell: use vzalloc rather than
	vmalloc and memset in spu_alloc_lscsa_std
Date: Sat, 30 Oct 2010 17:25:32 -0400
References: <alpine.LNX.2.00.1010302004290.1572@swampdragon.chaosbits.net>
In-Reply-To: <alpine.LNX.2.00.1010302004290.1572@swampdragon.chaosbits.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201010301725.32559.jk@ozlabs.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	Jesper Juhl <jj@chaosbits.net>,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jesper,

> We can get rid of a memset in
> arch/powerpc/platforms/cell/spufs/lscsa_alloc.c::spu_alloc_lscsa_std() by
> using vzalloc() rather than vmalloc()+memset().

Looks good to me.

Acked-By: Jeremy Kerr <jk@ozlabs.org>

Ben, could you apply this to the powerpc tree?

Cheers,


Jeremy
