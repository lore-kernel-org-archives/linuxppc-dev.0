Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C5EC001DC
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Jul 2023 07:49:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RCc8t3dqrz2yVn
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Jul 2023 17:49:34 +1000 (AEST)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RCc8J0sdZz2yVn
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Jul 2023 17:49:04 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4RCc8H2jSBz4wxR;
	Sat, 29 Jul 2023 17:49:03 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com, christophe.leroy@csgroup.eu, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
In-Reply-To: <20230724181320.471386-1-aneesh.kumar@linux.ibm.com>
References: <20230724181320.471386-1-aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH] powerpc/mm/altmap: Fix altmap boundary check
Message-Id: <169061688927.236508.16668889773877639158.b4-ty@ellerman.id.au>
Date: Sat, 29 Jul 2023 17:48:09 +1000
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
Cc: Dan Williams <dan.j.williams@intel.com>, David Hildenbrand <david@redhat.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 24 Jul 2023 23:43:20 +0530, Aneesh Kumar K.V wrote:
> altmap->free includes the entire free space from which altmap blocks
> can be allocated. So when checking whether the kernel is doing altmap
> block free, compute the boundary correctly.
> 
> 

Applied to powerpc/fixes.

[1/1] powerpc/mm/altmap: Fix altmap boundary check
      https://git.kernel.org/powerpc/c/6722b25712054c0f903b839b8f5088438dd04df3

cheers
