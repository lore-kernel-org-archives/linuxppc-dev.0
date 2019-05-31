Return-Path: <SRS0=knV+=T7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F212C04AB6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 May 2019 15:15:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0587426B6E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 May 2019 15:15:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0587426B6E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45Fp0P2R5rzDqd7
	for <linuxppc-dev@archiver.kernel.org>; Sat,  1 Jun 2019 01:15:01 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45Fnyt0rbvzDqXX
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Jun 2019 01:13:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 45Fnyr2t7Bz9s1c;
 Sat,  1 Jun 2019 01:13:40 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jonathan Corbet <corbet@lwn.net>, Bhupesh Sharma <bhsharma@redhat.com>
Subject: Re: [PATCH] Documentation/stackprotector: powerpc supports stack
 protector
In-Reply-To: <20190530081358.650930ad@lwn.net>
References: <1559212177-7072-1-git-send-email-bhsharma@redhat.com>
 <87v9xsnlu9.fsf@concordia.ellerman.id.au>
 <CACi5LpM9v1YC_6HhA-uKghawzkEu=TTPVkomMmv2i-LGi8X7+g@mail.gmail.com>
 <20190530081358.650930ad@lwn.net>
Date: Sat, 01 Jun 2019 01:13:36 +1000
Message-ID: <87ef4eodwf.fsf@concordia.ellerman.id.au>
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
Cc: Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Bhupesh SHARMA <bhupesh.linux@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Jonathan Corbet <corbet@lwn.net> writes:
> On Thu, 30 May 2019 18:37:46 +0530
> Bhupesh Sharma <bhsharma@redhat.com> wrote:
>
>> > This should probably go via the documentation tree?
>> >
>> > Acked-by: Michael Ellerman <mpe@ellerman.id.au>  
>> 
>> Thanks for the review Michael.
>> I am ok with this going through the documentation tree as well.
>
> Works for me too, but I don't seem to find the actual patch anywhere I
> look.  Can you send me a copy?

You can get it from lore:

  https://lore.kernel.org/linuxppc-dev/1559212177-7072-1-git-send-email-bhsharma@redhat.com/raw

Or patchwork (automatically adds my ack):

  https://patchwork.ozlabs.org/patch/1107706/mbox/

Or Bhupesh can send it to you :)

cheers
