Return-Path: <SRS0=hsDs=PQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA6CC43387
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 10:19:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B21612087F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 10:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B21612087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43YpCP5lvJzDqTJ
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 21:19:29 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Yp9h2gQQzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jan 2019 21:18:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43Yp9g5P8jz9s7T;
 Tue,  8 Jan 2019 21:17:59 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Darren Stevens <darren@stevens-zone.net>,
 Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/pasemi: Add Nemo board IRQ initroutine
In-Reply-To: <4d20f218a26.60da37fd@auth.smtp.1and1.co.uk>
References: <4c6da03c92f.ac1d78@auth.smtp.1and1.co.uk>
 <43MLSx0CY2z9sPY@ozlabs.org> <4d20f218a26.60da37fd@auth.smtp.1and1.co.uk>
Date: Tue, 08 Jan 2019 21:17:58 +1100
Message-ID: <875zuztpux.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, Christian Zigotzky <chzigotzky@xenosoft.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Darren Stevens <darren@stevens-zone.net> writes:
> Hello Michael
>
> On 22/12/2018, Michael Ellerman wrote:
>> On Sun, 2018-08-19 at 20:21:47 UTC, Darren Stevens wrote:
>>> Add a IRQ init routine for the Nemo board which inits and attatches
>>> the i8259 found in the SB600, and a cascade routine to dispatch the
>>> interrupts.
>>> 
>>> Signed-off-by: Darren Stevens <Darren@stevens-zone.net>
>>
>> Applied to powerpc next, thanks.
>
> Thankyou very much! We can now build a X1000 kernel without an out-of-tree patch, which is good.

Yay!

>> https://git.kernel.org/powerpc/c/51f4cc2047a4b7e9bf1b49acf06c11
>
> Sorry for not mentioning this earlier(holidays etc..), but this commit
> has my 4th patch, but the commit message from the 2nd patch. I don't
> know how, and it is not a major problem, but can we get it updated?

Urgh, cr#p. Not sure how I messed that up. I did have to edit all the
patches a bit to get them to apply so presumably somewhere along the
line the commit message got messed up to.

Unfortunately there's no way to fix it.

This email will have to suffice as documentation that it was me that
screwed it up and not you.

cheers
