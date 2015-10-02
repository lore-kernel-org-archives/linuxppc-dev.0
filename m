Return-Path: <michael@ozlabs.org>
In-Reply-To: <497c718e763173b28ffe4e50258cb257c362d404.1442259101.git.geoff@infradead.org>
To: Colin King <colin.king@canonical.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: cbe-oss-dev@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
 Colin Ian King <colin.king@canonical.com>
Subject: Re: [2/3] drivers/ps3: Fix ps3-vuart null dereference
Message-Id: <20151002074709.8EF71140316@ozlabs.org>
Date: Fri,  2 Oct 2015 17:47:09 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-14-09 at 19:35:04 UTC, Colin King wrote:
> On the unlikely event that drv is null, the current code will
> perform a null pointer dereference with it when printing a dev_dbg
> message.  Instead, the BUG_ON check on drv should be performed
> before we emit the dev_dbg message.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Signed-off-by: Geoff Levand <geoff@infradead.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6a6120bc5ec9e54d3cc06e73

cheers
