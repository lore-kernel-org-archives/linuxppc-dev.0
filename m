Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FADEC4167B
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Dec 2023 23:03:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SjQTY5Sh3z3dV3
	for <linuxppc-dev@archiver.kernel.org>; Sun,  3 Dec 2023 10:03:45 +1100 (AEDT)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SjQSc4tSVz3cSt
	for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Dec 2023 10:02:56 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4SjQSZ12GLz4x5j;
	Sun,  3 Dec 2023 10:02:54 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Jens Axboe <axboe@kernel.dk>, regressions <regressions@lists.linux.dev>, npiggin <npiggin@gmail.com>, christophe leroy <christophe.leroy@csgroup.eu>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Timothy Pearson <tpearson@raptorengineering.com>
In-Reply-To: <1921539696.48534988.1700407082933.JavaMail.zimbra@raptorengineeringinc.com>
References: <1921539696.48534988.1700407082933.JavaMail.zimbra@raptorengineeringinc.com>
Subject: Re: [PATCH v2] powerpc: Don't clobber fr0/vs0 during fp|altivec register save
Message-Id: <170155803785.146803.11553342425486262629.b4-ty@ellerman.id.au>
Date: Sun, 03 Dec 2023 10:00:37 +1100
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, 19 Nov 2023 09:18:02 -0600, Timothy Pearson wrote:
> During floating point and vector save to thread data fr0/vs0 are clobbered
> by the FPSCR/VSCR store routine.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc: Don't clobber fr0/vs0 during fp|altivec register save
      https://git.kernel.org/powerpc/c/5e1d824f9a283cbf90f25241b66d1f69adb3835b

cheers
