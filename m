Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A4FC433F5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 May 2022 11:20:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L6sFM2Rc9z3cDG
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 May 2022 21:20:39 +1000 (AEST)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4L6s7g3hzGz3bqf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2022 21:15:43 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4L6s7g2d5Zz4ySy;
 Tue, 24 May 2022 21:15:43 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: npiggin@gmail.com, Haren Myneni <haren@linux.ibm.com>, mscastanho@ibm.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <6dee950c7b72a4965c102208041f14a063cf5a8c.camel@linux.ibm.com>
References: <6dee950c7b72a4965c102208041f14a063cf5a8c.camel@linux.ibm.com>
Subject: Re: [PATCH] powerpc/pseries/vas: sysfs comments with the correct
 entries
Message-Id: <165339055903.1718562.7635571967949913504.b4-ty@ellerman.id.au>
Date: Tue, 24 May 2022 21:09:19 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, 09 Apr 2022 01:46:15 -0700, Haren Myneni wrote:
> VAS entry is created as a misc device and the sysfs comments
> should list the proper entries
> 
> 

Applied to powerpc/next.

[1/1] powerpc/pseries/vas: sysfs comments with the correct entries
      https://git.kernel.org/powerpc/c/657ac633302b9d694958a82654363cb559277759

cheers
