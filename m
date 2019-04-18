Return-Path: <SRS0=10v2=SU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76B7C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 09:47:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 455A620821
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 09:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nvkEZdQ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 455A620821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44lDlv5yC8zDqRw
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 19:47:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+46af72765985c7d61a7f+5716+infradead.org+mchehab@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="nvkEZdQ9"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44lDkB5yxrzDqQ4;
 Thu, 18 Apr 2019 19:45:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
 From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qMkC1T6ZJuUcdXnH9Yp0SsrwKBb1Irh2P/qjZGqcIw4=; b=nvkEZdQ9rFH3Terix674ZEQNo
 zCC4F0acxM9ojsrnHyOSjlqY9IfKpsl7TWinVqA7j7pqsQM0gWsi8gU011AauMKo3rimuqDWhhbYy
 KdiW8dseMvkzVJk0I+P0HB63KfkCHxCmWRrE/MKjIUfbD8gFW13T7Qkcj1IByCn7MpfotPWmvszMG
 aG6Q455QgSlVDU+/hF7IPRg2xl4DLB0QycoIsDxV0qI9734oVSfMaUohOfKr/35v0uyhNpYGm+O33
 1xsBqvrOHHFYeFrkKIoQobiUN/PaqSsKAzXjqj+9UfP8bBZ73hu1cBfbbB0QwligB4C0TP6d1ocgP
 EACpO1pcw==;
Received: from 177.132.233.55.dynamic.adsl.gvt.net.br ([177.132.233.55]
 helo=coco.lan)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hH3b3-0000fU-Ni; Thu, 18 Apr 2019 09:44:46 +0000
Date: Thu, 18 Apr 2019 06:44:36 -0300
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 21/21] docs: hwmon: Add an index file and rename docs
 to *.rst
Message-ID: <20190418064436.1803bf3a@coco.lan>
In-Reply-To: <20190417174728.GA17706@roeck-us.net>
References: <cover.1555494108.git.mchehab+samsung@kernel.org>
 <efbe0a2b5be35026c3a2dbdb9090c4fbd932c9a2.1555494108.git.mchehab+samsung@kernel.org>
 <20190417164741.GA12147@roeck-us.net>
 <20190417141352.3225bbb3@coco.lan>
 <20190417142215.791df5e7@coco.lan>
 <20190417174337.GA16749@roeck-us.net>
 <20190417174728.GA17706@roeck-us.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Mark Rutland <mark.rutland@arm.com>, Dirk Eibach <eibach@gdsys.de>,
 linux-aspeed@lists.ozlabs.org,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Clemens Ladisch <clemens@ladisch.de>, Kamil Debski <kamil@wypas.org>,
 Marc Hulsman <m.hulsman@tudelft.nl>, devicetree@vger.kernel.org,
 Huang Rui <ray.huang@amd.com>, Paul Mackerras <paulus@samba.org>,
 Jim Cromie <jim.cromie@gmail.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Jonathan Corbet <corbet@lwn.net>, Joel Stanley <joel@jms.id.au>,
 Steve Glendinning <steve.glendinning@shawell.net>,
 Fenghua Yu <fenghua.yu@intel.com>, Jean Delvare <jdelvare@suse.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Hans de Goede <hdegoede@redhat.com>,
 Rob Herring <robh+dt@kernel.org>, Rudolf Marek <r.marek@assembler.cz>,
 linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
 Support Opensource <support.opensource@diasemi.com>,
 George Joseph <george.joseph@fairview5.com>,
 Andreas Werner <andreas.werner@men.de>, Andrew Jeffery <andrew@aj.id.au>,
 patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
 Juerg Haefliger <juergh@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Em Wed, 17 Apr 2019 10:47:28 -0700
Guenter Roeck <linux@roeck-us.net> escreveu:

> On Wed, Apr 17, 2019 at 10:43:37AM -0700, Guenter Roeck wrote:
> > On Wed, Apr 17, 2019 at 02:22:15PM -0300, Mauro Carvalho Chehab wrote:  
> > > Em Wed, 17 Apr 2019 14:13:52 -0300
> > > Mauro Carvalho Chehab <mchehab+samsung@kernel.org> escreveu:
> > >   
> > > > Em Wed, 17 Apr 2019 09:47:41 -0700
> > > > Guenter Roeck <linux@roeck-us.net> escreveu:
> > > >   
> > > > > On Wed, Apr 17, 2019 at 06:46:29AM -0300, Mauro Carvalho Chehab wrote:    
> > > > > > Now that all files were converted to ReST format, rename them
> > > > > > and add an index.
> > > > > > 
> > > > > > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > > > > > Acked-by: Liviu Dudau <liviu.dudau@arm.com>      
> > > > > 
> > > > > I applied all patches except this one, which fails due to a conflict in
> > > > > ab8500. I also notice that this file has not been touched by your series,
> > > > > which is odd. At the same time, patch 20/21 is missing from your series,
> > > > > and has been missing all along. Does the missing patch possibly touch
> > > > > Documentation/hwmon/ab8500 ?    
> > > > 
> > > > Patch 20/21 is the biggest one. Maybe vger rejected it either due to
> > > > its size or due to the number of c/c.
> > > > 
> > > > Just bounced it to you. Please let me know if you didn't receive it
> > > > yet.  
> > > 
> > > Btw, LKML got it:
> > > 
> > > https://lore.kernel.org/lkml/cccc2a52363a5aaeea10e186ead8570503ea648e.1555494108.git.mchehab+samsung@kernel.org/
> > >   
> > patchwork didn't get it (or didn't accept it). I got it now.
> > All patches applied, and pushed out to hwmon-next.
> > 
> > We have one (new) unconverted file left - Documentation/hwmon/lochnagar.  
> 
> Plus ir38064 and isl68137. Lots of new drivers recently.

Ok, just sent a patch for those three new files. I wrote a more
detailed description about what steps I followed at the conversion
of those tree files, and why I did it. 

Hopefully, this would help hwmon developers
that may already be preparing a new driver for submission.

Thanks,
Mauro
