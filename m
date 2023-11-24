Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B406C61DF4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Nov 2023 16:04:27 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=XXKfoj9e;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ScKYP4ypdz3dX4
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Nov 2023 03:04:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=XXKfoj9e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2604:1380:4601:e00::1; helo=ams.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ScKXP46Msz3dBh
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Nov 2023 03:03:32 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id CA5B9B830E6;
	Fri, 24 Nov 2023 16:03:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D259AC433C7;
	Fri, 24 Nov 2023 16:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700841799;
	bh=Xbv2YQUV1GLAM7/VjlVRIIhik4WoZgE2mGIx3fwAybI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XXKfoj9esrjRdAzOsEQVbeIqhQA+R8Lumsy4x+QMGiq4MhdGjKFSmGmwWtf/QJCUR
	 gHwgsJTQXOyPXlkbue5GDGYHivMcQWCdBt1NGgEN7v7qX3CQbtqfqWtdDQz6UBKoJP
	 DNZ+Le0vLUjSmvRF3KsOKKsf2pNH22wJrTsd+J20=
Date: Fri, 24 Nov 2023 16:03:16 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: Please backport feea65a338e5 ("powerpc/powernv: Fix fortify
 source warnings in opal-prd.c")
Message-ID: <2023112409-undusted-grasp-e11e@gregkh>
References: <87edgl72ky.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87edgl72ky.fsf@mail.lhotse>
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
Cc: matoro_mailinglist_kernel@matoro.tk, linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Nov 20, 2023 at 10:20:13AM +1100, Michael Ellerman wrote:
> Hi,
> 
> Please backport feea65a338e5 ("powerpc/powernv: Fix fortify source
> warnings in opal-prd.c") to the 6.5, 6.1, 5.15, 5.10 stable trees.

Now queued up, thanks.

greg k-h
