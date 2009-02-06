Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5E232DDECF
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Feb 2009 03:44:54 +1100 (EST)
Message-Id: <67331C84-5400-4FE5-B6FA-395F13A482F8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Julia Lawall <julia@diku.dk>
In-Reply-To: <Pine.LNX.4.64.0902042236200.3091@ask.diku.dk>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] arch/powerpc: Eliminate double sizeof
Date: Fri, 6 Feb 2009 10:44:44 -0600
References: <Pine.LNX.4.64.0902042236200.3091@ask.diku.dk>
Cc: linuxppc-dev@ozlabs.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 4, 2009, at 3:43 PM, Julia Lawall wrote:

> From: Julia Lawall <julia@diku.dk>
>
> Taking sizeof the result of sizeof is quite strange and does not  
> seem to be
> what is wanted here.
>
> This was fixed using the following semantic patch.
> (http://www.emn.fr/x-info/coccinelle/)
>
> // <smpl>
> @@
> expression E;
> @@
>
> - sizeof (
>  sizeof (E)
> - )
>
> @@
> type T;
> @@
>
> - sizeof (
>  sizeof (T)
> - )
> // </smpl>
>
> Signed-off-by: Julia Lawall <julia@diku.dk>
> ---
> arch/powerpc/platforms/82xx/pq2ads-pci-pic.c |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

applied

- k
