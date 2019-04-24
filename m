Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C147BC10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 17:06:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D1BD2148D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 17:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MbCZxQuk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D1BD2148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44q6Cp4FCYzDqXl
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 03:06:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=mchehab+samsung@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="MbCZxQuk"; dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44q6B15fy5zDq77
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 03:04:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DCGeBvTyVQ8SMBoHvyttGac1kiVwGgaKGx64/cYbuDE=; b=MbCZxQukmg5r9iu99o5wQPndZ6
 /t8x9bkkfig6RtvUHiSTrQXjWGQxIHCK5fjmKxTlkICyMHJBTQQdEsuLfEuMdByY9DfNFvP/67jd5
 M9WSRQtIoGsnfbfS1+xAq2Qbm/1VmX2ZwshDmlMjSacekQp4OTny8w8Ot37uudoSgJTmZQDiK6+LG
 RHInVFxGa1V4zDbnenAYwzEZN9dRJw++CnrIhWyoj6hkJEQRMQVqkAFtaf56LoJIQco/EXMYIa02n
 /EAKvxnnlTumATOIOAKpAVpqH02tBqdW7rYe8+226PqQwQKk5PODZiuOixFPuyay06HhBw02f7JJW
 +n5kY6FQ==;
Received: from 177.17.136.231.dynamic.adsl.gvt.net.br ([177.17.136.231]
 helo=coco.lan)
 by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hJLJu-0006Bt-Im; Wed, 24 Apr 2019 17:04:31 +0000
Date: Wed, 24 Apr 2019 14:04:24 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH v4 37/63] Documentation: add Linux x86 docs to Sphinx
 TOC tree
Message-ID: <20190424140424.72d5ae56@coco.lan>
In-Reply-To: <20190423162932.21428-38-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
 <20190423162932.21428-38-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: fenghua.yu@intel.com, x86@kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, mingo@redhat.com,
 Bjorn Helgaas <bhelgaas@google.com>, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Em Wed, 24 Apr 2019 00:29:06 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> Add a index.rst for x86 support. More docs will be added later.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  Documentation/index.rst     | 1 +
>  Documentation/x86/index.rst | 9 +++++++++
>  2 files changed, 10 insertions(+)
>  create mode 100644 Documentation/x86/index.rst
> 
> diff --git a/Documentation/index.rst b/Documentation/index.rst
> index d80138284e0f..f185c8040fa9 100644
> --- a/Documentation/index.rst
> +++ b/Documentation/index.rst
> @@ -112,6 +112,7 @@ implementation.
>  .. toctree::
>     :maxdepth: 2
>  
> +   x86/index
>     sh/index
>  
>  Filesystem Documentation
> diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
> new file mode 100644
> index 000000000000..7612d3142b2a
> --- /dev/null
> +++ b/Documentation/x86/index.rst
> @@ -0,0 +1,9 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=================
> +Linux x86 Support
> +=================
> +
> +.. toctree::
> +   :maxdepth: 2
> +   :numbered:

Looks ok to me:

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Just one reminder: after merging both this and my conversions, we may
need to do some review at the architecture titles, in order to
make them consistent. 

On mu conversion patches, I'm using

	==================
	$arch Architecture
	==================

Probably also not the best title. Anyway, this can easily be fixed
with a follow up patch once we get everything merged.

Thanks,
Mauro
