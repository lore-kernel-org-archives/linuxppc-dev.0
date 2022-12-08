Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B4FFC3A5A7
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Dec 2022 12:56:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NSZ0p5fPZz3frW
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Dec 2022 23:56:42 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NSYrx6Clfz3bm9
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Dec 2022 23:49:53 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4NSYrx530Kz4xvX;
	Thu,  8 Dec 2022 23:49:53 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: npiggin@gmail.com, christophe.leroy@csgroup.eu, mpe@ellerman.id.au, Laurent Dufour <ldufour@linux.ibm.com>
In-Reply-To: <20221110180619.15796-1-ldufour@linux.ibm.com>
References: <20221110180619.15796-1-ldufour@linux.ibm.com>
Subject: Re: [PATCH v2 0/2] Consider the size of the added CPU nodes in the kexec FDT
Message-Id: <167050321905.1457988.13607875299113419626.b4-ty@ellerman.id.au>
Date: Thu, 08 Dec 2022 23:40:19 +1100
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 10 Nov 2022 19:06:17 +0100, Laurent Dufour wrote:
> When adding CPUs to an already big system (test show it seems to start with
> more than 256 CPUs), the kernel is showing error messages when building the
> FDT for the kexec kernel (kdump or kexec).
> 
> It's worth to mention that the kdump kernel is reloaded after a CPU add
> operation.
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc: export the CPU node count
      https://git.kernel.org/powerpc/c/e13d23a404f2e6dfaf8b1ef7d161a0836fce4fa5
[2/2] powerpc: Take in account addition CPU node when building kexec FDT
      https://git.kernel.org/powerpc/c/340a4a9f8773e102cc5ef531665970a686dfa245

cheers
