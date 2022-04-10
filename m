Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9445C433F5
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Apr 2022 12:29:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Kbrrd2HFlz3cF8
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Apr 2022 22:29:05 +1000 (AEST)
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KbrqQ6pVtz2xvW
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Apr 2022 22:28:02 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4KbrqQ5y3sz4xQq;
 Sun, 10 Apr 2022 22:28:02 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>
In-Reply-To: <20220330135123.1868197-1-srikar@linux.vnet.ibm.com>
References: <20220330135123.1868197-1-srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/numa: Handle partially initialized numa nodes
Message-Id: <164959362780.1306388.11008061889619945324.b4-ty@ellerman.id.au>
Date: Sun, 10 Apr 2022 22:27:07 +1000
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
Cc: linux-mm@kvack.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Geetika Moolchandani <Geetika.Moolchandani1@ibm.com>,
 Michal Hocko <mhocko@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 30 Mar 2022 19:21:23 +0530, Srikar Dronamraju wrote:
> With commit 09f49dca570a ("mm: handle uninitialized numa nodes
> gracefully") NODE_DATA for even a memoryless/cpuless node is partially
> initialized at boot time.
> 
> Before onlining the node, current Powerpc code checks for NODE_DATA to
> be NULL. However since NODE_DATA is partially initialized, this check
> will end up always being false.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/numa: Handle partially initialized numa nodes
      https://git.kernel.org/powerpc/c/e4ff77598a109bd36789ad5e80aba66fc53d0ffb

cheers
