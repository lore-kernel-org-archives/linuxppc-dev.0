Return-Path: <SRS0=Y6lA=T6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8CCC28CC2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 May 2019 14:16:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE2E625A76
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 May 2019 14:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE2E625A76
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45F8lQ1vMXzDqT7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 May 2019 00:16:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=lwn.net
 (client-ip=45.79.88.28; helo=ms.lwn.net; envelope-from=corbet@lwn.net;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lwn.net
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45F8hW6xS9zDqT8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 May 2019 00:14:02 +1000 (AEST)
Received: from lwn.net (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ms.lwn.net (Postfix) with ESMTPSA id CDA636D9;
 Thu, 30 May 2019 14:13:59 +0000 (UTC)
Date: Thu, 30 May 2019 08:13:58 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Bhupesh Sharma <bhsharma@redhat.com>
Subject: Re: [PATCH] Documentation/stackprotector: powerpc supports stack
 protector
Message-ID: <20190530081358.650930ad@lwn.net>
In-Reply-To: <CACi5LpM9v1YC_6HhA-uKghawzkEu=TTPVkomMmv2i-LGi8X7+g@mail.gmail.com>
References: <1559212177-7072-1-git-send-email-bhsharma@redhat.com>
 <87v9xsnlu9.fsf@concordia.ellerman.id.au>
 <CACi5LpM9v1YC_6HhA-uKghawzkEu=TTPVkomMmv2i-LGi8X7+g@mail.gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
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
Cc: Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Bhupesh SHARMA <bhupesh.linux@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 30 May 2019 18:37:46 +0530
Bhupesh Sharma <bhsharma@redhat.com> wrote:

> > This should probably go via the documentation tree?
> >
> > Acked-by: Michael Ellerman <mpe@ellerman.id.au>  
> 
> Thanks for the review Michael.
> I am ok with this going through the documentation tree as well.

Works for me too, but I don't seem to find the actual patch anywhere I
look.  Can you send me a copy?

Thanks,

jon
