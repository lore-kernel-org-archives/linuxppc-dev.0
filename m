Return-Path: <SRS0=HNI+=SN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A5DC10F13
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 13:04:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2EB120643
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 13:04:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2EB120643
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44g1SW4B70zDqT4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 23:04:11 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44g0CC2825zDqJ8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 22:07:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44g0CB15NTz9s4V;
 Thu, 11 Apr 2019 22:07:33 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Joe Perches <joe@perches.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: Re: [PATCH] MAINTAINERS: Update remaining @linux.vnet.ibm.com
 addresses
In-Reply-To: <0702bc9a10703d53a46f27468b2c9ef2463e1c0b.camel@perches.com>
References: <20190411042752.22039-1-lukas.bulwahn@gmail.com>
 <0702bc9a10703d53a46f27468b2c9ef2463e1c0b.camel@perches.com>
Date: Thu, 11 Apr 2019 22:07:32 +1000
Message-ID: <87k1g0vj7f.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: linux-pci@vger.kernel.org, "Paul E . McKenney" <paulmck@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Josh Boyer <jwboyer@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Joe Perches <joe@perches.com> writes:
> On Thu, 2019-04-11 at 06:27 +0200, Lukas Bulwahn wrote:
>> Paul McKenney attempted to update all email addresses @linux.vnet.ibm.com
>> to @linux.ibm.com in commit 1dfddcdb95c4
>> ("MAINTAINERS: Update from @linux.vnet.ibm.com to @linux.ibm.com"), but
>> some still remained.
>> 
>> We update the remaining email addresses in MAINTAINERS, hopefully finally
>> catching all cases for good.
>
> Perhaps update all the similar addresses in other files too
>
> $ git grep --name-only 'linux\.vnet\.ibm\.com' | wc -l
> 315

A good number of them are no longer valid. So I'm not sure it's worth
updating them en masse to addresses that won't ever work.

We have git now, we don't need email addresses in files, they're just
prone to bitrot like this.

Should we just change them all like so?

  -arch/powerpc/boot/dts/bamboo.dts: * Josh Boyer <jwboyer@linux.vnet.ibm.com>
  +arch/powerpc/boot/dts/bamboo.dts: * Josh Boyer (IBM)


To indicate the author was at IBM when they wrote it?

Or should we try and update them with current addresses? Though then the
authors might start getting mails they don't want.

cheers
