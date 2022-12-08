Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D435C3A5A7
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Dec 2022 12:56:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NSZ0D68clz3fPL
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Dec 2022 23:56:12 +1100 (AEDT)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NSYrx2Rcxz3c69
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Dec 2022 23:49:53 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4NSYrx1Jxpz4xN1;
	Thu,  8 Dec 2022 23:49:53 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: christophe.leroy@csgroup.eu, npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, Laurent Dufour <ldufour@linux.ibm.com>
In-Reply-To: <20221125173204.15329-1-ldufour@linux.ibm.com>
References: <20221125173204.15329-1-ldufour@linux.ibm.com>
Subject: Re: [PATCH] pseries/mobility: reset the RCU watchdogs after a LPM
Message-Id: <167050321981.1457988.18096782970217396456.b4-ty@ellerman.id.au>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 25 Nov 2022 18:32:04 +0100, Laurent Dufour wrote:
> The RCU watchdog timer should be reset when restarting the CPU after a Live
> Partition Mobility operation.
> 
> 

Applied to powerpc/next.

[1/1] pseries/mobility: reset the RCU watchdogs after a LPM
      https://git.kernel.org/powerpc/c/9b574cfab7d4e68c67c4ee4fcde912ef54a25b88

cheers
