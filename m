Return-Path: <SRS0=tR2X=R4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5163C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 23:39:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E00920848
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 23:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E00920848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44SrMm2TNCzDqKr
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 10:39:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=perches.com
 (client-ip=216.40.44.48; helo=smtprelay.hostedemail.com;
 envelope-from=joe@perches.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=perches.com
Received: from smtprelay.hostedemail.com (smtprelay0048.hostedemail.com
 [216.40.44.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44SrL80JXYzDq7X
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2019 10:38:23 +1100 (AEDT)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay03.hostedemail.com (Postfix) with ESMTP id B9CB6837F24C;
 Mon, 25 Mar 2019 23:38:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wish00_e884140d0c40
X-Filterd-Recvd-Size: 1699
Received: from XPS-9350.home (unknown [47.151.153.53])
 (Authenticated sender: joe@perches.com)
 by omf08.hostedemail.com (Postfix) with ESMTPA;
 Mon, 25 Mar 2019 23:38:19 +0000 (UTC)
Message-ID: <87e98473d586e2549f49829e62738cd8738ec873.camel@perches.com>
Subject: Re: Bad file pattern in MAINTAINERS section 'IBM Power Virtual
 Accelerator Switchboard'
From: Joe Perches <joe@perches.com>
To: linux-kernel@vger.kernel.org
Date: Mon, 25 Mar 2019 16:38:18 -0700
In-Reply-To: <20190325233521.31094-1-joe@perches.com>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
 <20190325233521.31094-1-joe@perches.com>
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
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2019-03-25 at 16:35 -0700, Joe Perches wrote:
> A file pattern line in this section of the MAINTAINERS file in linux-next
> does not have a match in the linux source files.
> 
> This could occur because a matching filename was never added, was deleted
> or renamed in some other commit.
> 
> The commits that added and if found renamed or removed the file pattern
> are shown below.
> 
> Please fix this defect appropriately.
> 
> 1: ---------------------------------------------------------------------------
> 
> linux-next MAINTAINERS section:
> 
> 	7396	IBM Power Virtual Accelerator Switchboard
> 	7397	M:	Sukadev Bhattiprolu

btw: Your name needs an email address here too.

This should be:

M:	Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>


