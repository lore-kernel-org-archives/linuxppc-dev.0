Return-Path: <paulus@ozlabs.org>
Date: Thu, 20 May 2010 13:03:24 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] powerpc: Fix string library functions
Message-ID: <20100520030324.GA31208@drongo>
References: <m2bpcdjcue.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <m2bpcdjcue.fsf@igel.home>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 18, 2010 at 08:15:21PM +0200, Andreas Schwab wrote:

> The powerpc strncmp implementation does not correctly handle a zero
> length, despite the claim in 0119536cd314ef95553604208c25bc35581f7f0a
> (Add hand-coded assembly strcmp).
> 
> Additionally, all the length arguments are size_t, not int, so use
> PPC_LCMPI and eq instead of cmpwi and le throughout.
> 
> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>

Looks fine to me.

Acked-by: Paul Mackerras <paulus@samba.org>
