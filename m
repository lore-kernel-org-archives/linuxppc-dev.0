Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: cell spu problem state mapping updates
Date: Fri, 29 Sep 2006 09:52:01 +0200
References: <1159506605.15792.24.camel@localhost.localdomain>
In-Reply-To: <1159506605.15792.24.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200609290952.02365.arnd@arndb.de>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	"cbe-oss-dev@ozlabs.org" <cbe-oss-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 29 September 2006 07:10, Benjamin Herrenschmidt wrote:
> This patch adds a new "psmap" file to spufs that allows mmap of all of
> the problem state mapping of SPEs. It is compatible with 64k pages. In
> addition, it removes mmap ability of individual files when using 64k
> pages, with the exception of signal1 and signal2 which will both map the
> entire 64k page holding both registers. It also removes
> CONFIG_SPUFS_MMAP as there is no point in not building mmap support in
> spufs.
> 
> It goes along a separate patch to libspe implementing usage of that new
> file to access problem state registers.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
