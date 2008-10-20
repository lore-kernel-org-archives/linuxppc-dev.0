Return-Path: <dgibson@ozlabs.org>
Date: Mon, 20 Oct 2008 11:44:04 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] powerpc: remove device_type = "board-control"
Message-ID: <20081020004404.GA24084@yookeroo.seuss>
References: <20081018002352.GA9661@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081018002352.GA9661@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Oct 18, 2008 at 04:23:52AM +0400, Anton Vorontsov wrote:
> We don't want to encourage the bogus device_type usage.
> 
> The device type isn't used in the code, so we can simply remove it from
> the documentation and dts files.
> 
> Boards should specify proper compatible entries instead.
> 
> Suggested-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
