Return-Path: <SRS0=N2MO=QO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7B5C282C2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 23:00:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 118F12175B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 23:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Nhoq7i5W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 118F12175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wYg26MqczDqV8
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 09:59:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="Nhoq7i5W"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wYdC1ZMQzDqTq
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2019 09:58:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nSee9vn3ui7QGmIO5421TKMAowDx4TIVEscC2C546FM=; b=Nhoq7i5WDo+WVMdTXkNfNCexV
 vh0wcaQhW1BYqKPNN9LqYTBL3azM7tXxOgvRY6MNMy7/WwsAy/XQVlEX7Cad4TKjgg5AI/wAAyxbS
 VBO6siypV3bS69vB+cK/x/BOe54h8XP7vQrlWCD+eCyvp3m1DzR/snePqXH/ElFKXD3XjDFfaVjWD
 OX/YXsDyHbnp0wYyvgFzvg+NtdHEnczlAd5zzsB+IT/bBA4INLbOY0mD/XAZ+Enm71AWEA7ZNK4vU
 9WkSCsfb0HsP6dzzHVQV0U8eV15KLmBxddJP8csk3dcLdgxxgFBjbBAJ3IqF+KiyP6CPXkEc27GCO
 gFGdx91AA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16]
 helo=midway.dunlab)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grscd-0003lk-Oy; Thu, 07 Feb 2019 22:58:19 +0000
Subject: Re: [PATCH 1/1] docs: powerpc: Convert to RST format
To: "Tobin C. Harding" <tobin@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>
References: <20190207060316.3221-1-tobin@kernel.org>
 <20190207060316.3221-2-tobin@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2fc7fe53-af80-f3b8-1f17-ff7c2dc2be3c@infradead.org>
Date: Thu, 7 Feb 2019 14:58:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190207060316.3221-2-tobin@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
Cc: linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 2/6/19 10:03 PM, Tobin C. Harding wrote:
> The PowerPC docs have yet to be converted to RST format.  Let's kick it
> off by doing all the files that _don't_ contain ASCII art.
> 
> - Add SPDX license identifier to each new RST file.
> 
>     .. SPDX-License-Identifier: GPL-2.0
> 
> - User correct heading adornments.
> 
> - Make all lines < 72 characters in width.
> 
> - Use correct indentation for code blocks, add syntax highlighting
> 
> - Sparingly use double ticks if it makes the files easier to parse
>   both in text and on the web.
> 
> - Fix any super obvious typos (lean towards not making changes so that
>   we don't introduce errors).
> 
> Edited as text files (obviously) and formatted as HTML to verify
> rendering, no other formats verified.
> 
> Convert docs to RST format, adding license.
> 
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

thanks.


> ---
>  Documentation/index.rst                       |   1 +
>  Documentation/powerpc/DAWR-POWER9.rst         |  60 ++++
>  Documentation/powerpc/DAWR-POWER9.txt         |  58 ---
>  Documentation/powerpc/bootwrapper.rst         | 140 ++++++++
>  Documentation/powerpc/bootwrapper.txt         | 141 --------
>  Documentation/powerpc/conf.py                 |  10 +
>  Documentation/powerpc/cpu_features.rst        |  62 ++++
>  Documentation/powerpc/cpu_features.txt        |  56 ---
>  .../powerpc/eeh-pci-error-recovery.rst        | 319 +++++++++++++++++
>  .../powerpc/eeh-pci-error-recovery.txt        | 334 ------------------
>  Documentation/powerpc/index.rst               |  21 ++
>  Documentation/powerpc/isa-versions.rst        | 234 ++++++++----
>  Documentation/powerpc/mpc52xx.rst             |  52 +++
>  Documentation/powerpc/mpc52xx.txt             |  39 --
>  Documentation/powerpc/pmu-ebb.rst             | 148 ++++++++
>  Documentation/powerpc/pmu-ebb.txt             | 137 -------
>  Documentation/powerpc/ptrace.rst              | 177 ++++++++++
>  Documentation/powerpc/ptrace.txt              | 151 --------
>  .../{syscall64-abi.txt => syscall64-abi.rst}  |  80 +++--
>  .../powerpc/transactional_memory.rst          | 259 ++++++++++++++
>  .../powerpc/transactional_memory.txt          | 244 -------------
>  21 files changed, 1460 insertions(+), 1263 deletions(-)
>  create mode 100644 Documentation/powerpc/DAWR-POWER9.rst
>  delete mode 100644 Documentation/powerpc/DAWR-POWER9.txt
>  create mode 100644 Documentation/powerpc/bootwrapper.rst
>  delete mode 100644 Documentation/powerpc/bootwrapper.txt
>  create mode 100644 Documentation/powerpc/conf.py
>  create mode 100644 Documentation/powerpc/cpu_features.rst
>  delete mode 100644 Documentation/powerpc/cpu_features.txt
>  create mode 100644 Documentation/powerpc/eeh-pci-error-recovery.rst
>  delete mode 100644 Documentation/powerpc/eeh-pci-error-recovery.txt
>  create mode 100644 Documentation/powerpc/index.rst
>  create mode 100644 Documentation/powerpc/mpc52xx.rst
>  delete mode 100644 Documentation/powerpc/mpc52xx.txt
>  create mode 100644 Documentation/powerpc/pmu-ebb.rst
>  delete mode 100644 Documentation/powerpc/pmu-ebb.txt
>  create mode 100644 Documentation/powerpc/ptrace.rst
>  delete mode 100644 Documentation/powerpc/ptrace.txt
>  rename Documentation/powerpc/{syscall64-abi.txt => syscall64-abi.rst} (58%)
>  create mode 100644 Documentation/powerpc/transactional_memory.rst
>  delete mode 100644 Documentation/powerpc/transactional_memory.txt


-- 
~Randy
