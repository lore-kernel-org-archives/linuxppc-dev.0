Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C0DC10F03
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 17:38:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAE9C214AE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 17:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFKifiku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAE9C214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pVzG3m48zDqP6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 03:38:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=helgaas@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="RFKifiku"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pVxX3tFnzDqN1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 03:36:47 +1000 (AEST)
Received: from localhost (odyssey.drury.edu [64.22.249.253])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 02F66206BA;
 Tue, 23 Apr 2019 17:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1556041005;
 bh=0ywx4lbgLqdcOUJmTJLQ1S0sd6blYojEzZMGaehyCq4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RFKifikufVAAEiYElOfFEZNBmaOX2AaURO7CJBO43uVnIm7SiUToincr0CoU5SipS
 eq2M2g/oAiDcLtIuc216jiwUzJebwpsyrWM9ejkKSSdRE8ZRTqbu9nljumpqsQwuQ6
 IfP1DjparUtNRl4DWKZkRDEo/m77cCe09UE43KGY=
Date: Tue, 23 Apr 2019 12:36:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 00/63] Include linux ACPI/PCI/X86 docs into Sphinx TOC
 tree
Message-ID: <20190423173644.GA14616@google.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
 <CAJZ5v0jPyaGQcDfpW5b7A-_3bvkfL78MxFmPtjwCGZ4-=KwUwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jPyaGQcDfpW5b7A-_3bvkfL78MxFmPtjwCGZ4-=KwUwg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Fenghua Yu <fenghua.yu@intel.com>,
 the arch/x86 maintainers <x86@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Linux PCI <linux-pci@vger.kernel.org>, linux-gpio@vger.kernel.org,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Ingo Molnar <mingo@redhat.com>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Changbin Du <changbin.du@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Apr 23, 2019 at 06:39:47PM +0200, Rafael J. Wysocki wrote:
> On Tue, Apr 23, 2019 at 6:30 PM Changbin Du <changbin.du@gmail.com> wrote:
> > Hi Corbet and All,
> > The kernel now uses Sphinx to generate intelligent and beautiful
> > documentation from reStructuredText files. I converted all of the Linux
> > ACPI/PCI/X86 docs to reST format in this serias.
> >
> > In this version I combined ACPI and PCI docs, and added new x86 docs
> > conversion.
> 
> I'm not sure if combining all three into one big patch series has been
> a good idea, honestly.

Yeah, if you post this again, I would find it easier to deal with if
linux-pci only got the PCI-related things.  63 patches is a little too
much for one series.

Bjorn
