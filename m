Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18079.62282.890470.115431@cargo.ozlabs.ibm.com>
Date: Fri, 20 Jul 2007 09:27:06 +1000
From: Paul Mackerras <paulus@samba.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 01/12] Split out common parts of prom.h
In-Reply-To: <20070720010742.e60c67a7.sfr@canb.auug.org.au>
References: <20070718173024.50204a1a.sfr@canb.auug.org.au>
	<20070720010742.e60c67a7.sfr@canb.auug.org.au>
Cc: sparclinux@vger.kernel.org, ppc-dev <linuxppc-dev@ozlabs.org>,
	"David S. Miller" <davem@davemloft.net>, wli@holomorphy.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell writes:

> This creates linux/of.h and includes asm/prom.h from it.
> 
> We also include linux/of.h from asm/prom.h while we transition.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: Paul Mackerras <paulus@samba.org>

for all 12 of the series.
