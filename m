Return-Path: <dan.j.williams@gmail.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
	by ozlabs.org (Postfix) with ESMTP id 67EF9B70F1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Sep 2010 06:31:41 +1000 (EST)
Received: by wwa36 with SMTP id 36so1859303wwa.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Sep 2010 13:31:38 -0700 (PDT)
MIME-Version: 1.0
Sender: dan.j.williams@gmail.com
In-Reply-To: <1284774162-14652-1-git-send-email-tmarri@apm.com>
References: <1284774162-14652-1-git-send-email-tmarri@apm.com>
Date: Thu, 23 Sep 2010 13:29:47 -0700
Message-ID: <AANLkTin2pyo0Ua952poK8E+-bdeKMfYd9nyd-5tx7RD9@mail.gmail.com>
Subject: Re: [PATCH 2/2] PPC4xx: Merge xor.h and dma.h into onefile
	ppc440spe-dma.h
From: Dan Williams <dan.j.williams@intel.com>
To: tmarri@apm.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: neilb@suse.de, yur@emcraft.com, linux-raid@vger.kernel.org,
	herbert@gondor.hengli.com.au, linux-crypto@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 17, 2010 at 6:42 PM,  <tmarri@apm.com> wrote:
> From: Tirumala Marri <tmarri@apm.com>
> This patch combines drivers/dma/ppc4xx/xor.h and driver/dma/dma/ppc4xx/dma.h
> into drivers/dma/ppc4xx/ppx440spe-dma.h .
>

Is this just code churn, or do we gain anything by combining these
header files?  Don't add "ppc440spe-" back to the prefix, we're
already in the ppc4xx directory, unless the file will only contain
definitions that are relevant to ppc440spe.

--
Dan
