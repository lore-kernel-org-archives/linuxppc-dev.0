Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D05C32771
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Aug 2022 11:31:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4M8KMh3D7Zz3f1d
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Aug 2022 21:31:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=L2w4AjTk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=L2w4AjTk;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4M8KM24ZPFz3cFl
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2022 21:30:54 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D438B617A2;
	Fri, 19 Aug 2022 11:30:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9FBEC433C1;
	Fri, 19 Aug 2022 11:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1660908650;
	bh=2wmzVDjvgJ9VN/rNXBeeXF8n+o7D9JOizsre5p5+uGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L2w4AjTk+kdoYlFopZXjM6Zh5xTFyJ57Yxc5gKmNGCQ7/EK5SCMgLo1ZgO+AvLE2o
	 iY6aGASGPF56WPCAWvoXTxvnz7CdOmN8XFqAV0QKb2wSt/qsWFsZJn/6O+fXAgZYJM
	 I95oR8pNyrn6p0yen97Q/wX0vzvjiIlc3vAZLs9E=
Date: Fri, 19 Aug 2022 13:30:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/boot: Convert more files to use SPDX tags
Message-ID: <Yv90ZxeQbf7smJCH@kroah.com>
References: <20220819110430.433984-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819110430.433984-1-mpe@ellerman.id.au>
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
Cc: linux-spdx@vger.kernel.org, tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Aug 19, 2022 at 09:04:30PM +1000, Michael Ellerman wrote:
> These files are all plain GPL 2.0, with a second sentence about being
> licensed as-is.
> 
> Similar to the rule in commit 577b61cee5b2 ("treewide: Replace GPLv2
> boilerplate/reference with SPDX - gpl-2.0_398.RULE").
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/boot/44x.h          | 5 +----
>  arch/powerpc/boot/4xx.h          | 5 +----
>  arch/powerpc/boot/ops.h          | 6 ++----
>  arch/powerpc/boot/serial.c       | 6 ++----
>  arch/powerpc/boot/simple_alloc.c | 6 ++----
>  5 files changed, 8 insertions(+), 20 deletions(-)


Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Do you want this to go through the SPDX tree, or will you route it
through the normal ppc tree?  Either is fine with me, just let me know
if you want me to take it in the SPDX tree.

thanks,

greg k-h
