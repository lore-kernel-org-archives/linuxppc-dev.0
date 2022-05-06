Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC39C433EF
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 May 2022 10:57:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Kvnb42Fmvz3c7Z
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 May 2022 20:57:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gondor.apana.org.au (client-ip=216.24.177.18;
 helo=fornost.hmeau.com; envelope-from=herbert@gondor.apana.org.au;
 receiver=<UNKNOWN>)
X-Greylist: delayed 1989 seconds by postgrey-1.36 at boromir;
 Fri, 06 May 2022 20:57:11 AEST
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KvnZb0mb8z2yQ9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 May 2022 20:57:11 +1000 (AEST)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
 by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
 id 1nmv7K-00AgLS-Hp; Fri, 06 May 2022 20:23:24 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation);
 Fri, 06 May 2022 18:23:22 +0800
Date: Fri, 6 May 2022 18:23:22 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH] crypto: vmx - Align the short log with Makefile cleanups
Message-ID: <YnT3GtU975OsXVuN@gondor.apana.org.au>
References: <20220501130749.1123387-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220501130749.1123387-1-masahiroy@kernel.org>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Nayna Jain <nayna@linux.ibm.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linux-crypto@vger.kernel.org,
 Breno =?iso-8859-1?Q?Leit=E3o?= <leitao@debian.org>,
 Paulo Flabiano Smorigo <pfsmorigo@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, May 01, 2022 at 10:07:49PM +0900, Masahiro Yamada wrote:
> I notieced the log is not properly aligned:
> 
>   PERL drivers/crypto/vmx/aesp8-ppc.S
>   CC [M]  fs/xfs/xfs_reflink.o
>   PERL drivers/crypto/vmx/ghashp8-ppc.S
>   CC [M]  drivers/crypto/vmx/aes.o
> 
> Add some spaces after 'PERL'.
> 
> While I was here, I cleaned up the Makefile:
> 
>  - Merge the two similar rules
> 
>  - Remove redundant 'clean-files' (Having 'targets' is enough)
> 
>  - Move the flavour into the build command
> 
> This still avoids the build failures fixed by commit 4ee812f6143d
> ("crypto: vmx - Avoid weird build failures").
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  drivers/crypto/vmx/Makefile | 17 +++--------------
>  1 file changed, 3 insertions(+), 14 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
