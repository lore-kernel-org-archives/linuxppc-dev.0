Return-Path: <SRS0=vMbJ=5Z=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4458C2D0EA
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Apr 2020 05:55:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3781820771
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Apr 2020 05:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORXGoZ2T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3781820771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48yVjj2n9PzDr15
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Apr 2020 15:55:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=mchehab+huawei@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=ORXGoZ2T; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48yVgT06KbzDr0K
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Apr 2020 15:53:24 +1000 (AEST)
Received: from coco.lan (ip5f5ad4d8.dynamic.kabel-deutschland.de
 [95.90.212.216])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2702B20771;
 Thu,  9 Apr 2020 05:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586411602;
 bh=PZpwEDZqalrcZdaZXg391xQtawvNQl0BlnXyC7AWgW8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=ORXGoZ2Tz6as4vV23sFw8z/3wIbJRRFAQmahJjuY70zN/mX4V0IsA5Peh3ADZ48tI
 oXoKzz9WSuUi9EP4aCzT/P6lr9Qu2K2hXuGtFhng9d45Grt/4zzT8tcllUxJAqPzaZ
 kouAO9cFh8+hqfd/DlS8y39QrfaIjOZLCFElIq04=
Date: Thu, 9 Apr 2020 07:53:16 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Andrew Donnellan <ajd@linux.ibm.com>
Subject: Re: [PATCH 31/35] powerpc: docs: cxl.rst: mark two section titles
 as such
Message-ID: <20200409075316.01edd295@coco.lan>
In-Reply-To: <fc649189-91cc-bb73-8d07-34054629a2b3@linux.ibm.com>
References: <cover.1586359676.git.mchehab+huawei@kernel.org>
 <cccd2886af9961aad2a69fce96c0cf4f06995d6d.1586359676.git.mchehab+huawei@kernel.org>
 <fc649189-91cc-bb73-8d07-34054629a2b3@linux.ibm.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
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
Cc: Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Frederic Barrat <fbarrat@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Em Thu, 9 Apr 2020 10:37:52 +1000
Andrew Donnellan <ajd@linux.ibm.com> escreveu:

> On 9/4/20 1:46 am, Mauro Carvalho Chehab wrote:
> > The User API chapter contains two sub-chapters. Mark them as
> > such.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> 
> Thanks.
> 
> Though the other subsections in this file use ----- rather than ^^^^^, 
> what's the difference?

ReST syntax allows the usage of several different markup symbols for
titles. It dynamically attributes the first one it finds as level 1,
the second one as level 2 and so on.

As we added the "^^^^" markup before "-----", after this patch, it now has:

	=======
	level 1
	=======

	level 2
	=======

	level 3
	^^^^^^^

	level 4
	-------


> 
> Acked-by: Andrew Donnellan <ajd@linux.ibm.com>
> 
> > ---
> >   Documentation/powerpc/cxl.rst | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/powerpc/cxl.rst b/Documentation/powerpc/cxl.rst
> > index 920546d81326..d2d77057610e 100644
> > --- a/Documentation/powerpc/cxl.rst
> > +++ b/Documentation/powerpc/cxl.rst
> > @@ -133,6 +133,7 @@ User API
> >   ========
> >   
> >   1. AFU character devices
> > +^^^^^^^^^^^^^^^^^^^^^^^^
> >   
> >       For AFUs operating in AFU directed mode, two character device
> >       files will be created. /dev/cxl/afu0.0m will correspond to a
> > @@ -395,6 +396,7 @@ read
> >   
> >   
> >   2. Card character device (powerVM guest only)
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >   
> >       In a powerVM guest, an extra character device is created for the
> >       card. The device is only used to write (flash) a new image on the
> >   
> 



Thanks,
Mauro
