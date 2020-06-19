Return-Path: <SRS0=VXZ8=AA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5EDC433DF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2020 20:22:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6027720890
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2020 20:22:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6027720890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49pVbg0nfRzDrVn
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Jun 2020 06:22:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=lwn.net
 (client-ip=45.79.88.28; helo=ms.lwn.net; envelope-from=corbet@lwn.net;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lwn.net
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49pVYM0sSxzDrSg
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Jun 2020 06:20:35 +1000 (AEST)
Received: from lwn.net (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ms.lwn.net (Postfix) with ESMTPSA id 642172CD;
 Fri, 19 Jun 2020 20:20:31 +0000 (UTC)
Date: Fri, 19 Jun 2020 14:20:30 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH 00/22] ReST conversion patches (final?)
Message-ID: <20200619142030.6feed35e@lwn.net>
In-Reply-To: <cover.1592203650.git.mchehab+huawei@kernel.org>
References: <cover.1592203650.git.mchehab+huawei@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Rich Felker <dalias@libc.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 David Airlie <airlied@linux.ie>, Catalin Marinas <catalin.marinas@arm.com>,
 Dragan Cvetic <dragan.cvetic@xilinx.com>, linux-pci@vger.kernel.org,
 Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
 Harry Wei <harryxiyou@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Alex Shi <alex.shi@linux.alibaba.com>, Will Deacon <will@kernel.org>,
 Javi Merino <javi.merino@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org,
 Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Derek Kiernan <derek.kiernan@xilinx.com>, linux-crypto@vger.kernel.org,
 Ohad Ben-Cohen <ohad@wizery.com>, devicetree@vger.kernel.org,
 Daniel Vetter <daniel@ffwll.ch>,
 Michael Hennerich <michael.hennerich@analog.com>, linux-pm@vger.kernel.org,
 linux-remoteproc@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 dri-devel@lists.freedesktop.org, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Amit Daniel Kachhap <amit.kachhap@gmail.com>, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, tee-dev@lists.linaro.org,
 Vinod Koul <vkoul@kernel.org>, keyrings@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Masami Hiramatsu <mhiramat@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, dmaengine@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Jens Wiklander <jens.wiklander@linaro.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 15 Jun 2020 08:50:05 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> That's my final(*) series of conversion patches from .txt to ReST.
> 
> (*) Well, running the script I'm using to check, I noticed a couple of new *.txt files.
> If I have some time, I'll try to address those last pending things for v5.9.

OK, I've applied the set except for parts:

 1: |copy| as mentioned before
 18: because of the license boilerplate
 19: doesn't apply at all (perhaps because of one of the above)
 22: because I don't like the latex markup.

Also, I took the liberty of just reverting the |copy| change in #10.

Getting there..!

Thanks,

jon
