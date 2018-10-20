Return-Path: <SRS0=IXoQ=NA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469A9C67863
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Oct 2018 22:59:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E9B821550
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Oct 2018 22:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E9B821550
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42cysK4btXzF1hT
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Oct 2018 09:59:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=buserror.net
 (client-ip=165.227.176.147; helo=baldur.buserror.net;
 envelope-from=oss@buserror.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=buserror.net
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42cyqC13CKzF0BV
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Oct 2018 09:57:39 +1100 (AEDT)
Received: from [2601:449:8400:7293:12bf:48ff:fe84:c9a0]
 by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <oss@buserror.net>)
 id 1gE09S-0007SS-LN; Sat, 20 Oct 2018 17:55:22 -0500
Message-ID: <5c5b0d6dbbfb23811f3c6de062f50e035f441cab.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Darren Stevens <darren@stevens-zone.net>
Date: Sat, 20 Oct 2018 17:55:21 -0500
In-Reply-To: <f98693387706211e2ced1de2606b7ac7dcd3fcb3.camel@buserror.net>
References: <0F797F4E-755B-499C-BA74-48CC03235393@xenosoft.de>
 <76A7B415-F6D4-4BF8-B4B7-B146C5337CF8@xenosoft.de>
 <196C6151-3085-4A42-B6D6-5891F4AF9759@xenosoft.de>
 <07ad630cccbd33c81031f690fd17cdc30b662e49.camel@buserror.net>
 <4c796dccb9b.4d269848@auth.smtp.1and1.co.uk>
 <f98693387706211e2ced1de2606b7ac7dcd3fcb3.camel@buserror.net>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8400:7293:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: darren@stevens-zone.net, chzigotzky@xenosoft.de,
 linuxppc-dev@lists.ozlabs.org
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: FSL/NXP P5020: USB problems with the latest Git kernels
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
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
Cc: linuxppc-dev@lists.ozlabs.org, Christian Zigotzky <chzigotzky@xenosoft.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2018-08-29 at 18:30 -0500, Scott Wood wrote:
> On Tue, 2018-08-28 at 20:13 +0100, Darren Stevens wrote:
> > Hello Scott
> > 
> > On 27/08/2018, Scott Wood wrote:
> > > On Mon, 2018-08-27 at 20:15 +0200, Christian Zigotzky wrote:
> > > > Hello,
> > > > 
> > > > Our users tested the RC1 of kernel 4.19 on their P5020 boards today.
> > > > Unfortunately the USB bug still exists. With mem values bigger than
> > > > 4096M,
> > > > the USB mouse and keyboard doesn't work. With the bootarg mem=4096M,
> > > > the
> > > > USB
> > > > devices work without any problems. Please compile the RC1 and test it
> > > > on
> > > > your P5020 board. There is a problem with the memory management since
> > > > 22/08/18. 
> > > 
> > > I just tested 4.19-rc1 on a T4240 and got a similar problem with
> > > MMC.  MMC
> > > and
> > > USB on these chips both have a 32-bit DMA limitation.  I'll look into
> > > it.
> > 
> > I've run a bisect locally on my system and found the following bad commit:
> > 
> > # first bad commit: [1b1eeca7e4c19fa76d409d4c7b338dba21f2df45] init: allow
> > initcall tables to be emitted using relative references
> > 
> > I can't see why this would fail though, and it only seems to affect fsl
> > machines, and on mine it killed the onboard sata as well.
> > 
> > Hope this helps.
> 
> 
> The patch is changing the order of initcalls.  swiotlb_setup_bus_notifier()
> and corenet_gen_publish_devices() are both machine_arch_initcall(), and if
> the
> latter happens before the former, then the bus notifier gets missed and
> swiotlb doesn't get used.

While it would be nice to fix this ordering dependency at some point, the
change was reverted on PPC by commit ff69279a44e9ba876466 ("powerpc: disable
support for relative ksymtab references").

-Scott

