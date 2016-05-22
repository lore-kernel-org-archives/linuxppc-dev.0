Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rCbBy5W0YzDqBt
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 May 2016 07:58:02 +1000 (AEST)
Date: Mon, 23 May 2016 07:53:59 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Andrea Gelmini <andrea.gelmini@gelma.net>
Cc: trivial@kernel.org, benh@kernel.crashing.org, mpe@ellerman.id.au,
 aneesh.kumar@linux.vnet.ibm.com, imunsie@au1.ibm.com,
 scottwood@freescale.com, mikey@neuling.org, cyrilbur@gmail.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0230/1529] Fix typo
Message-ID: <20160522215359.GB26398@fergus.ozlabs.ibm.com>
References: <20160521120636.11948-1-andrea.gelmini@gelma.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160521120636.11948-1-andrea.gelmini@gelma.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, May 21, 2016 at 02:06:36PM +0200, Andrea Gelmini wrote:
> Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
> ---
>  arch/powerpc/mm/hash_native_64.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
> index d873f65..0a4560d 100644
> --- a/arch/powerpc/mm/hash_native_64.c
> +++ b/arch/powerpc/mm/hash_native_64.c
> @@ -55,7 +55,7 @@ static inline void __tlbie(unsigned long vpn, int psize, int apsize, int ssize)
>  	 * We need 14 to 65 bits of va for a tlibe of 4K page
>  	 * With vpn we ignore the lower VPN_SHIFT bits already.
>  	 * And top two bits are already ignored because we can
> -	 * only accomadate 76 bits in a 64 bit vpn with a VPN_SHIFT
> +	 * only accomodate 76 bits in a 64 bit vpn with a VPN_SHIFT

accommodate
