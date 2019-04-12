Return-Path: <SRS0=dpXp=SO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3BBC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 16:18:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C856B20850
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 16:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C856B20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44gjjl3H5wzDqTN
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Apr 2019 02:18:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=perches.com
 (client-ip=216.40.44.164; helo=smtprelay.hostedemail.com;
 envelope-from=joe@perches.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=perches.com
Received: from smtprelay.hostedemail.com (smtprelay0164.hostedemail.com
 [216.40.44.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44gjh10xr6zDqRR
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Apr 2019 02:16:31 +1000 (AEST)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay05.hostedemail.com (Postfix) with ESMTP id 4B9251801922E;
 Fri, 12 Apr 2019 16:16:26 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: sugar26_71814fc27bc2a
X-Filterd-Recvd-Size: 1525
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
 (Authenticated sender: joe@perches.com)
 by omf03.hostedemail.com (Postfix) with ESMTPA;
 Fri, 12 Apr 2019 16:16:19 +0000 (UTC)
Message-ID: <08ef1432f9c1906234132abc9ab449f7f08b6cd8.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: Update remaining @linux.vnet.ibm.com
 addresses
From: Joe Perches <joe@perches.com>
To: paulmck@linux.ibm.com
Date: Fri, 12 Apr 2019 09:16:18 -0700
In-Reply-To: <20190411131222.GW14111@linux.ibm.com>
References: <20190411042752.22039-1-lukas.bulwahn@gmail.com>
 <0702bc9a10703d53a46f27468b2c9ef2463e1c0b.camel@perches.com>
 <87k1g0vj7f.fsf@concordia.ellerman.id.au>
 <921408ed6a19d9c6fed18182f03a6dac5ea42aae.camel@perches.com>
 <20190411131222.GW14111@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
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
Cc: Tyrel Datwyler <tyreld@linux.ibm.com>, Josh Boyer <jwboyer@kernel.org>,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2019-04-11 at 06:12 -0700, Paul E. McKenney wrote:
> If my email address were
> to change again, I would instead go with the "(IBM)" approach and let
> the git log and MAINTAINERS file keep the contact information.  Not that
> we get to update the git log, of course.  ;-)

Add entries to .mailmap works too.


