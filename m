Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Jesper Juhl <jj@chaosbits.net>
Subject: Re: [PATCH] PowerPC/Cell: use vzalloc rather than vmalloc and memset
	in spu_alloc_lscsa_std
Date: Sat, 30 Oct 2010 23:41:22 +0200
References: <alpine.LNX.2.00.1010302004290.1572@swampdragon.chaosbits.net>
In-Reply-To: <alpine.LNX.2.00.1010302004290.1572@swampdragon.chaosbits.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201010302341.22738.arnd@arndb.de>
Cc: cbe-oss-dev@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Saturday 30 October 2010, Jesper Juhl wrote:
> We can get rid of a memset in 
> arch/powerpc/platforms/cell/spufs/lscsa_alloc.c::spu_alloc_lscsa_std() by 
> using vzalloc() rather than vmalloc()+memset().
> 
> Completely untested patch below since I have no hardware nor tools to 
> compile this.
> 
> 
> Signed-off-by: Jesper Juhl <jj@chaosbits.net>

Acked-by: Arnd Bergmann <arnd@arndb.de>
