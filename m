Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 837E9C433EF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Feb 2022 21:00:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Jtb4W3Swrz2yPv
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Feb 2022 08:00:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=youngman.org.uk (client-ip=85.233.160.19; helo=smtp.hosts.co.uk;
 envelope-from=antlists@youngman.org.uk; receiver=<UNKNOWN>)
X-Greylist: delayed 6642 seconds by postgrey-1.36 at boromir;
 Wed, 09 Feb 2022 07:37:38 AEDT
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JtZZV63V5z2yPv
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Feb 2022 07:37:37 +1100 (AEDT)
Received: from host81-132-12-162.range81-132.btcentralplus.com
 ([81.132.12.162] helo=[192.168.1.218])
 by smtp.hosts.co.uk with esmtpa (Exim)
 (envelope-from <antlists@youngman.org.uk>)
 id 1nHVTm-000AKN-99; Tue, 08 Feb 2022 18:44:43 +0000
Message-ID: <0c20be6e-87f2-b9dc-4c9a-85680ba10417@youngman.org.uk>
Date: Tue, 8 Feb 2022 18:44:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/3] lib/raid6/test/Makefile: Use `$(pound)` instead of
 `\#` for Make 4.3
Content-Language: en-GB
To: Paul Menzel <pmenzel@molgen.mpg.de>, Song Liu <song@kernel.org>
References: <20220126114144.370517-1-pmenzel@molgen.mpg.de>
From: Wols Lists <antlists@youngman.org.uk>
In-Reply-To: <20220126114144.370517-1-pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 09 Feb 2022 07:59:49 +1100
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
Cc: linux-raid@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Matt Brown <matthew.brown.dev@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 26/01/2022 11:41, Paul Menzel wrote:
> So, do the same as commit 9564a8cf422d (Kbuild: fix # escaping in .cmd
> files for future Make) and commit 929bef467771 (bpf: Use $(pound) instead
> of \# in Makefiles) and define and use a `$(pound)` variable.

Ouch!

In the English (as opposed to American) speaking world this will be very 
confusing! The pound sign is £ not #.

If this is not dictated by some sort of upstream PLEASE can we make it 
$(hash) not $(pound)

Cheers,
Wol
