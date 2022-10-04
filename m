Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7971C433FE
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Oct 2022 13:41:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Mhf4g2fwSz3f0L
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Oct 2022 00:41:39 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Mhf1M41m0z3bjc
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2022 00:38:47 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mhf1L4JMQz4xGm;
	Wed,  5 Oct 2022 00:38:46 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: cgel.zte@gmail.com, mpe@ellerman.id.au
In-Reply-To: <20220825072657.229168-1-ye.xingchen@zte.com.cn>
References: <20220825072657.229168-1-ye.xingchen@zte.com.cn>
Subject: Re: [PATCH linux-next] powerpc/pseries/vas: Remove the unneeded result variable
Message-Id: <166488995937.779920.17176528386276511230.b4-ty@ellerman.id.au>
Date: Wed, 05 Oct 2022 00:25:59 +1100
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
Cc: nathanl@linux.ibm.com, nick.child@ibm.com, ye xingchen <ye.xingchen@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>, haren@linux.ibm.com, linux-kernel@vger.kernel.org, Julia.Lawall@inria.fr, npiggin@gmail.com, wangborong@cdjrlc.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 25 Aug 2022 07:26:57 +0000, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Return the value vas_register_coproc_api() directly instead of storing it
> in another redundant variable.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/pseries/vas: Remove the unneeded result variable
      https://git.kernel.org/powerpc/c/91986d7f0300c2c01722e0eac5119bb0946fe9b5

cheers
