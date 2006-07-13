Return-Path: <muli@il.ibm.com>
Date: Thu, 13 Jul 2006 09:39:47 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [PATCH] powerpc: simplify dma_ops bug conditions
Message-ID: <20060713063947.GD5096@rhun.ibm.com>
References: <20060713063252.1D35867B58@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060713063252.1D35867B58@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 13, 2006 at 04:32:52PM +1000, Jeremy Kerr wrote:

> Use BUG_ON rather than BUG to simplify the dma_ops handing,
> and remove the now-unnecessary return cases.
> 
> Booted on pseries.

Is the BUG_ON() necessary? the next line just goes and deref's it,
which should lead to a shiny NULL pointer deref.

Cheers,
Muli
