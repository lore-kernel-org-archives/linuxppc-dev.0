Return-Path: <SRS0=KSz9=SP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8DFC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Apr 2019 00:28:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7E862084E
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Apr 2019 00:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qRkeB63T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7E862084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44gwbB6gCPzDqWL
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Apr 2019 10:28:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=mchehab+samsung@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="qRkeB63T"; dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44gwYK1TdMzDqCD;
 Sat, 13 Apr 2019 10:26:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4mQ9cEOwWsjtS00QxTayhbQ57nO91ztak7S0dPl4OCA=; b=qRkeB63T/VDW/K1SrqBJjuulkZ
 F2Qe/Gv89KZaClsUhOo3tq+ciBVgxFl7goed5PTgh7/VxqooIG6QUsNkhY9cLanR7iQaq4QfrTiHp
 5Be7GLO/HidpS4mrLedilzPdUMO7TIj9M7xXVjM4CDQ4p9KuauMCL1NA4dMwQ7lse2cFYvUhXIoaL
 TVa1Lm9NSPY6akwTxXYU6xnoAvW/ooQSkTpsWXdqVpTffYN0MkPBOwKzPGBF+KOF+ORMYiEs4Nqkx
 pfDGXPdLIzuiJqkC1M9J8OagYHAoRlu+2Un1za6vV9JJ835F9YWj+yrBrwKO8RFJYD+PtHARV8jl9
 EiF3RxtA==;
Received: from 201.86.162.146.dynamic.adsl.gvt.net.br ([201.86.162.146]
 helo=coco.lan)
 by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hF6US-0002NC-62; Sat, 13 Apr 2019 00:25:52 +0000
Date: Fri, 12 Apr 2019 21:25:41 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 00/21] Convert hwmon documentation to ReST
Message-ID: <20190412212541.0cde9452@coco.lan>
In-Reply-To: <8514ff97-3167-3c89-3468-e247d14c5086@roeck-us.net>
References: <cover.1554923967.git.mchehab+samsung@kernel.org>
 <20190411124324.3ed62fad@lwn.net>
 <20190411174357.251904f5@coco.lan>
 <20190411210731.GA29378@roeck-us.net>
 <20190412100451.6fe49de7@lwn.net>
 <8514ff97-3167-3c89-3468-e247d14c5086@roeck-us.net>
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
Cc: linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
 linux-aspeed@lists.ozlabs.org,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Andrew Jeffery <andrew@aj.id.au>, Jonathan Corbet <corbet@lwn.net>,
 Liviu Dudau <liviu.dudau@arm.com>, linux-kernel@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab@infradead.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Paul Mackerras <paulus@samba.org>, Joel Stanley <joel@jms.id.au>,
 linuxppc-dev@lists.ozlabs.org, Sudeep Holla <sudeep.holla@arm.com>,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Em Fri, 12 Apr 2019 09:12:52 -0700
Guenter Roeck <linux@roeck-us.net> escreveu:

> On 4/12/19 9:04 AM, Jonathan Corbet wrote:
> > On Thu, 11 Apr 2019 14:07:31 -0700
> > Guenter Roeck <linux@roeck-us.net> wrote:
> >   
> >>> While nobody does such split, IMHO, the best would be to keep the
> >>> information outside Documentation/admin-guide. But hey! You're
> >>> the Doc maintainer. If you prefer to move, I'm perfectly fine
> >>> with that.
> >>>      
> >>
> >> Same here, but please don't move the files which are kernel facing only.  
> > 
> > Well, let's step back and think about this.  Who is the audience for
> > these documents?  That will tell us a lot about where they should really
> > be.
> >   
> 
> Most of them are for users, some of them are for driver developers. A few
> are for both, though that is generally not the intention (and one may argue
> that driver internal documentation should be moved into the respective
> driver source).

The big issue is really those files that contain both kernel internals
and userspace stuff.

This is a common pattern. I just finishing converting a lot more
documents to ReST and I found the same thing on almost all document
directories I touched.

> > What I would prefer to avoid is the status quo where *everything* is in
> > the top-level directory, and where documents are organized for the
> > convenience of their maintainers rather than of their readers.  But
> > sometimes I feel like I'm alone in that desire...:)
> >   
> I am fine with separating user pointing from kernel API/driver developer
> guides, and I agree that it would make a lot of sense. As I said, please
> just make sure that kernel facing files don't end up in the wrong directory.

I like the idea of splitting user faced documents from the rest, but
this is not an easy task. On several cases, there are just a couple
of paragraphs with things like sysfs entries in the middle of a big
file with Kernel internals.

Thanks,
Mauro
