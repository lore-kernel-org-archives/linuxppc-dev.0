Return-Path: <dgibson@ozlabs.org>
Date: Thu, 23 Aug 2007 12:54:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] ucc_geth: kill unused include
Message-ID: <20070823025438.GE7042@localhost.localdomain>
References: <Pine.LNX.4.64.0708222144440.6464@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0708222144440.6464@blarg.am.freescale.net>
Cc: netdev@vger.kernel.org, Li Yang <leoli@freescale.com>,
	Paul Mackerras <paulus@samba.org>, Jeff Garzik <jeff@garzik.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 22, 2007 at 09:51:03PM -0500, Kumar Gala wrote:
> The ucc_geth_mii code is based on the gianfar_mii code that use to include
> ocp.h.  ucc never need this and it causes issues when we want to kill
> arch/ppc includes from arch/powerpc.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
