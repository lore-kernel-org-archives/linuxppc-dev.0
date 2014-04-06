Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C3C39140093
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Apr 2014 09:48:55 +1000 (EST)
Message-ID: <1396828110.3671.21.camel@pasglop>
Subject: Re: [PATCH 1/2] fixup: "powerpc/perf: Add support for the hv 24x7
 interface"
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Cody P Schafer <cody@linux.vnet.ibm.com>
Date: Mon, 07 Apr 2014 09:48:30 +1000
In-Reply-To: <1396476654-20623-2-git-send-email-cody@linux.vnet.ibm.com>
References: <1396476654-20623-1-git-send-email-cody@linux.vnet.ibm.com>
 <1396476654-20623-2-git-send-email-cody@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: cody+local@linux.vnet.ibm.com, LKML <linux-kernel@vger.kernel.org>,
 Michael Ellerman <michael@ellerman.id.au>, David.Laight@aculab.com,
 Anton Blanchard <anton@samba.org>, Linux PPC <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-04-02 at 15:10 -0700, Cody P Schafer wrote:
> Make the "not enabled" message less awful.
> 
> Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
> ---
>  arch/powerpc/perf/hv-24x7.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
> index 297c9105..3246ea2 100644
> --- a/arch/powerpc/perf/hv-24x7.c
> +++ b/arch/powerpc/perf/hv-24x7.c
> @@ -491,7 +491,7 @@ static int hv_24x7_init(void)
>  
>  	hret = hv_perf_caps_get(&caps);
>  	if (hret) {
> -		pr_info("could not obtain capabilities, error 0x%80lx, not enabling\n",
> +		pr_info("could not obtain capabilities, not enabling (%ld)\n",
>  				hret);

That's not much less awful... The message gives 0 informations about
where it comes from .. what is it that couldn't obtain capabilities ?

Also, sentences start with a Capital.

Cheers,
Ben.
 
