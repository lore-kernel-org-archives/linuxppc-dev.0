Return-Path: <SRS0=HNI+=SN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B75DC10F13
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 20:46:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DA2E2146F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 20:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ml67nDSf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DA2E2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44gCjW11yVzDqT7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 06:46:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=mchehab+samsung@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="ml67nDSf"; dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44gCgh6NXLzDqQP;
 Fri, 12 Apr 2019 06:44:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=e9Z/7e3/hRsGnS2IGdT3ZcpPF2Keute9G8FZSvjPYvw=; b=ml67nDSf8iAwnEALQB1I8vyqA8
 TS0UFAHu4F1JxQDfKqgX4khtCfCdm/PNWWp8FlxfUL99uzN2HQOx+4IDNHFU5FGEv9O7sv8yzZEs3
 do+3nQvj8OqYxn2AwfvufaI2prXL19tSuh1JOugN7O6qRW/E91lUjXRs5ksYawU06OU7ltn2UDkk9
 4drePCv1T5mbCpYRxmqLazFVy6Xrdwfe5A6AaAtdHMTZ93NqEYt29XBKrVkePqBxaNZ5n/E3AiKWp
 hvktN8LDszwkexr2gk7xY5cJcwmDrZckik1bgoUqT807DsY1VHtEE157AYGNBEBi7oBeGlOCFGBsT
 +DZPLIaA==;
Received: from 201.86.162.146.dynamic.adsl.gvt.net.br ([201.86.162.146]
 helo=coco.lan)
 by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hEgYH-0001OQ-If; Thu, 11 Apr 2019 20:44:06 +0000
Date: Thu, 11 Apr 2019 17:43:57 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 00/21] Convert hwmon documentation to ReST
Message-ID: <20190411174357.251904f5@coco.lan>
In-Reply-To: <20190411124324.3ed62fad@lwn.net>
References: <cover.1554923967.git.mchehab+samsung@kernel.org>
 <20190411124324.3ed62fad@lwn.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
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
Cc: linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
 Jean Delvare <jdelvare@suse.com>, linux-aspeed@lists.ozlabs.org,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Andrew Jeffery <andrew@aj.id.au>, Sudeep Holla <sudeep.holla@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, linux-kernel@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab@infradead.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Paul Mackerras <paulus@samba.org>, Joel Stanley <joel@jms.id.au>,
 linuxppc-dev@lists.ozlabs.org, Guenter Roeck <linux@roeck-us.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Em Thu, 11 Apr 2019 12:43:24 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Wed, 10 Apr 2019 16:22:37 -0300
> Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> 
> > This series converts the contents of Documentation/hwmon to ReST
> > format.
> > 
> > PS.: I opted to group the conversion files per groups of maintainer
> > set, as, if I were to generate one patch per file, it would give around
> > 160 patches.
> > 
> > I also added those patches to my development tree at:
> > 	https://git.linuxtv.org/mchehab/experimental.git/log/?h=hwmon
> > 
> > If you want to see the results, they're at:
> > 	https://www.infradead.org/~mchehab/hwmon/  
> 
> This set seems generally good and could probably be applied as-is.  But I
> have to ask...is there a reason to not take the last step and actually
> bring this stuff into the Sphinx doc tree?
> 
> We seem to be mostly documenting sysfs files and such.  I am *guessing*
> that perhaps the set should move to Documentation/admin-guide/hwmon?  Or
> have I misunderstood the intended audience here?

:-)

Yeah, I'd say that 80% of the contents there are user-faced.

Yet, the main issue with this (and other driver subsystems) is that there's
a mix of userspace and Kernelspace stuff. One somewhat simple case is
the abituguru: it has a "datasheet" file:

	abituguru-datasheet

This contains programming information for the corresponding drivers,
while abituguru and abituguru3 contains mostly userspace
stuff (still, it also contains the I2C address, with shouldn't mean
anything for the user).

However, if you take a look at w83781d, you'll see a mix of both
userspace and driver developer info there... it has a chapter called
"Data sheet updates", for example, with is probably meaningless for
anyone but the hwmon driver developers.

That's, btw, a pattern that happens a lot inside device driver
documents on almost all subsystems I checked: driver-specific
documentation is usually not split into user-facing/kernel-facing.

While nobody does such split, IMHO, the best would be to keep the
information outside Documentation/admin-guide. But hey! You're
the Doc maintainer. If you prefer to move, I'm perfectly fine
with that.


Thanks,
Mauro
