Return-Path: <SRS0=n2Bs=OC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08E0C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 19:02:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EFA620824
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 19:02:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EFA620824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 431lzd56sSzDqLT
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Nov 2018 06:02:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=suse.de
 (client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=msuchanek@suse.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.de
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 431lxF2Gt8zDqWv
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Nov 2018 05:59:59 +1100 (AEDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 7EB91AD73;
 Fri, 23 Nov 2018 18:59:56 +0000 (UTC)
Date: Fri, 23 Nov 2018 19:59:55 +0100
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Li Yang <leoyang.li@nxp.com>
Subject: Re: Spectre+Meltdown
Message-ID: <20181123195955.1bdcdd80@kitsune.suse.cz>
In-Reply-To: <CADRPPNRtexannDrv8WtD2f3sQr9nwkN2PPgvh6m2r4d6BvqitQ@mail.gmail.com>
References: <36E75811-C758-49B1-8E5C-3A2C44FD5DE9@xenosoft.de>
 <874lnzz5y3.fsf@concordia.ellerman.id.au>
 <86eade29-a56d-2aab-050e-366f4d43ab2f@xenosoft.de>
 <CAOesGMhGt6arTt9p9rxT8Qreaucae0i=fmQoqkBvUGJOxobhiQ@mail.gmail.com>
 <CAOMqctS0d9i5F1si3mDq_M1ZZM1MncXRBFKGeZ4y30J4H_1RDg@mail.gmail.com>
 <32e12e24-750d-eb98-0753-f5feca309082@xenosoft.de>
 <CADRPPNRtexannDrv8WtD2f3sQr9nwkN2PPgvh6m2r4d6BvqitQ@mail.gmail.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Olof Johansson <olof@lixom.net>, Michal Suchanek <hramrach@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Christian Zigotzky <chzigotzky@xenosoft.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 10 Jan 2018 18:09:45 -0600
Li Yang <leoyang.li@nxp.com> wrote:

Hello,

> On Mon, Jan 8, 2018 at 2:17 AM, Christian Zigotzky
> <chzigotzky@xenosoft.de> wrote:
> > Hi All,
> >
> > Thanks a lot for your replies.
> >
> > @NXP developers: Could you please tell us some information?  
> 
> We have done some investigation but it is not ready to be published
> yet.  You can get more information from your support channel right
> now.

With this summary paper https://arxiv.org/abs/1811.05441 it should be
possible to take the manual for your favourite CPU and see which
exploitable optimizations it does have, and how are these exploits
mitigated.

Thanks

Michal

