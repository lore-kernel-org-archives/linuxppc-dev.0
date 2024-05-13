Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E188C25B10
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 May 2024 13:23:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VdKtY58qcz3cfy
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 May 2024 23:23:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VdKsm5MnZz3cPS
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2024 23:22:36 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VdKsc3xhFz4x0y;
	Mon, 13 May 2024 23:22:28 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20240510082114.561163-1-hbathini@linux.ibm.com>
References: <20240510082114.561163-1-hbathini@linux.ibm.com>
Subject: Re: [PATCH] powerpc/fadump: update documentation about bootargs_append
Message-Id: <171560652134.57553.16142052953374067970.b4-ty@ellerman.id.au>
Date: Mon, 13 May 2024 23:22:01 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 10 May 2024 13:51:14 +0530, Hari Bathini wrote:
> Update ABI documentation about the introduction of the new sysfs
> entry bootargs_append. This sysfs entry will be used to setup the
> additional parameters to be passed to dump capture kernel.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/fadump: update documentation about bootargs_append
      https://git.kernel.org/powerpc/c/9dc140785961e53b1d45d186961a3b0d374bfc6a

cheers
