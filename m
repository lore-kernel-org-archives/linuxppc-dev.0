Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD808C19F29
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Aug 2022 06:46:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4M0Cfz1hyfz3bZ2
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Aug 2022 16:46:35 +1000 (AEST)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4M0Cf864Kjz2xHX
	for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Aug 2022 16:45:52 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4M0Cf85BmYz4x1c;
	Sat,  6 Aug 2022 16:45:52 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <20220802105723.1055178-1-mpe@ellerman.id.au>
References: <20220802105723.1055178-1-mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/pci: Fix PHB numbering when using opal-phbid
Message-Id: <165976833235.1752861.9537134294346532546.b4-ty@ellerman.id.au>
Date: Sat, 06 Aug 2022 16:45:32 +1000
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
Cc: pali@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2 Aug 2022 20:57:23 +1000, Michael Ellerman wrote:
> The recent change to the PHB numbering logic has a logic error in the
> handling of "ibm,opal-phbid".
> 
> When an "ibm,opal-phbid" property is present, &prop is written to and
> ret is set to zero.
> 
> The following call to of_alias_get_id() is skipped because ret == 0.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/pci: Fix PHB numbering when using opal-phbid
      https://git.kernel.org/powerpc/c/f4b39e88b42d13366b831270306326b5c20971ca

cheers
