Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6496FA3745
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Nov 2022 12:28:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4N1q7J36wbz3f90
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Nov 2022 23:28:28 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4N1q5m12sQz3f43
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Nov 2022 23:27:08 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4N1q5l6m2Dz4xN0;
	Tue,  1 Nov 2022 23:27:07 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Andreas Schwab <schwab@linux-m68k.org>, Rohan McLure <rmclure@linux.ibm.com>
In-Reply-To: <87mt9cxd6g.fsf_-_@igel.home>
References: <20220921065605.1051927-1-rmclure@linux.ibm.com> <20220921065605.1051927-22-rmclure@linux.ibm.com> <87mt9cxd6g.fsf_-_@igel.home>
Subject: Re: [PATCH] powerpc/32: fix syscall wrappers with 64-bit arguments
Message-Id: <166730554940.2453885.9553402143339300323.b4-ty@ellerman.id.au>
Date: Tue, 01 Nov 2022 23:25:49 +1100
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
Cc: linuxppc-dev@lists.ozlabs.org, Andrew Donnellan <ajd@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 31 Oct 2022 15:47:35 +0100, Andreas Schwab wrote:
> With the introducion of syscall wrappers all wrappers for syscalls with
> 64-bit arguments must be handled specially, not only those that have
> unaligned 64-bit arguments.  This left out the fallocate and
> sync_file_range2 syscalls.
> 
> 

Applied to powerpc/fixes.

[1/1] powerpc/32: fix syscall wrappers with 64-bit arguments
      https://git.kernel.org/powerpc/c/ce883a2ba310cd7c291bb66ce5d207965fca6003

cheers
