Return-Path: <SRS0=HNI+=SN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257F4C10F13
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 13:06:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B2652133D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 13:06:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B2652133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44g1WB46QgzDqD9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 23:06:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=perches.com
 (client-ip=216.40.44.113; helo=smtprelay.hostedemail.com;
 envelope-from=joe@perches.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=perches.com
Received: from smtprelay.hostedemail.com (smtprelay0113.hostedemail.com
 [216.40.44.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44g0fN2BbfzDqN0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 22:27:38 +1000 (AEST)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay04.hostedemail.com (Postfix) with ESMTP id C5EC2180A8123;
 Thu, 11 Apr 2019 12:27:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: coast83_5f0e5b204912b
X-Filterd-Recvd-Size: 2769
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com
 [23.242.196.136]) (Authenticated sender: joe@perches.com)
 by omf20.hostedemail.com (Postfix) with ESMTPA;
 Thu, 11 Apr 2019 12:27:33 +0000 (UTC)
Message-ID: <921408ed6a19d9c6fed18182f03a6dac5ea42aae.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: Update remaining @linux.vnet.ibm.com
 addresses
From: Joe Perches <joe@perches.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Lukas Bulwahn
 <lukas.bulwahn@gmail.com>, Tyrel Datwyler <tyreld@linux.ibm.com>
Date: Thu, 11 Apr 2019 05:27:31 -0700
In-Reply-To: <87k1g0vj7f.fsf@concordia.ellerman.id.au>
References: <20190411042752.22039-1-lukas.bulwahn@gmail.com>
 <0702bc9a10703d53a46f27468b2c9ef2463e1c0b.camel@perches.com>
 <87k1g0vj7f.fsf@concordia.ellerman.id.au>
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
Cc: linux-pci@vger.kernel.org, "Paul E . McKenney" <paulmck@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Josh Boyer <jwboyer@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2019-04-11 at 22:07 +1000, Michael Ellerman wrote:
> Joe Perches <joe@perches.com> writes:
> > On Thu, 2019-04-11 at 06:27 +0200, Lukas Bulwahn wrote:
> > > Paul McKenney attempted to update all email addresses @linux.vnet.ibm.com
> > > to @linux.ibm.com in commit 1dfddcdb95c4
> > > ("MAINTAINERS: Update from @linux.vnet.ibm.com to @linux.ibm.com"), but
> > > some still remained.
> > > 
> > > We update the remaining email addresses in MAINTAINERS, hopefully finally
> > > catching all cases for good.
> > 
> > Perhaps update all the similar addresses in other files too
> > 
> > $ git grep --name-only 'linux\.vnet\.ibm\.com' | wc -l
> > 315
> 
> A good number of them are no longer valid. So I'm not sure it's worth
> updating them en masse to addresses that won't ever work.
> 
> We have git now, we don't need email addresses in files, they're just
> prone to bitrot like this.
> 
> Should we just change them all like so?
> 
>   -arch/powerpc/boot/dts/bamboo.dts: * Josh Boyer <jwboyer@linux.vnet.ibm.com>
>   +arch/powerpc/boot/dts/bamboo.dts: * Josh Boyer (IBM)
> 
> To indicate the author was at IBM when they wrote it?

If that's desired, perhaps:

$ git grep -P --name-only '<?[\w\.]+(?:@| at )linux\.vnet\.ibm\.com>?' | \
  grep -vP '\.mailmap|MAINTAINERS' | \
  xargs perl -p -i -e 's/<?[\w\.]+(?:@|\ at\ )linux\.vnet\.ibm\.com>?/(IBM)/g'

> Or should we try and update them with current addresses? Though then the
> authors might start getting mails they don't want.

That'd be my preference.

If authors get emails they don't want, then those contact
emails should be removed.


