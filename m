Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id CB1B2B70DA
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 19 Sep 2010 07:12:03 +1000 (EST)
To: tmarri@apm.com
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 2/2] PPC4xx: Merge xor.h and dma.h into onefile
	ppc440spe-dma.h
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <1284774162-14652-1-git-send-email-tmarri@apm.com>
References: <1284774162-14652-1-git-send-email-tmarri@apm.com>
Date: Sat, 18 Sep 2010 23:12:01 +0200
Message-Id: <20100918211201.EE714157D71@gemini.denx.de>
Cc: herbert@gondor.apana.org.au, neilb@suse.de, yur@emcraft.com,
	linux-raid@vger.kernel.org, linux-crypto@vger.kernel.org,
	dan.j.williams@intel.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear tmarri@apm.com,

In message <1284774162-14652-1-git-send-email-tmarri@apm.com> you wrote:
> From: Tirumala Marri <tmarri@apm.com>
> 
> This patch combines drivers/dma/ppc4xx/xor.h and driver/dma/dma/ppc4xx/dma.h
> into drivers/dma/ppc4xx/ppx440spe-dma.h .
> 
> Signed-off-by: Tirumala R Marri <tmarri@apm.com>
> ---
>  drivers/dma/ppc4xx/dma.h           |  223 -------------------------
>  drivers/dma/ppc4xx/ppc440spe-dma.h |  318 ++++++++++++++++++++++++++++++++++++
>  drivers/dma/ppc4xx/xor.h           |  110 -------------
>  3 files changed, 318 insertions(+), 333 deletions(-)

Please use -M with "git format-patch" so it detects renames (here we
should probably see a rename from dma.h into ppc440spe-dma.h [plus
some changes]) instead of a remove plus add file.

That would make it much easier to review your changes.

Thanks.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
It's a small world, but I wouldn't want to paint it.
