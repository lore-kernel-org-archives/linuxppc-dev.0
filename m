Return-Path: <SRS0=1Xda=S6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D8EC43218
	for <linuxppc-dev@archiver.kernel.org>; Sun, 28 Apr 2019 06:18:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9011F206E0
	for <linuxppc-dev@archiver.kernel.org>; Sun, 28 Apr 2019 06:18:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9011F206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44sHfw4NY4zDqLg
	for <linuxppc-dev@archiver.kernel.org>; Sun, 28 Apr 2019 16:18:48 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44sHdK09QjzDqQX
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Apr 2019 16:17:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44sHdJ4Z7sz9s9T; Sun, 28 Apr 2019 16:17:24 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44sHdG5Kj9z9s9N;
 Sun, 28 Apr 2019 16:17:22 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH stable v4.4 00/52] powerpc spectre backports for 4.4
In-Reply-To: <20190421163421.GA8449@kroah.com>
References: <20190421142037.21881-1-mpe@ellerman.id.au>
 <20190421163421.GA8449@kroah.com>
Date: Sun, 28 Apr 2019 16:17:28 +1000
Message-ID: <87o94qac1z.fsf@concordia.ellerman.id.au>
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
Cc: npiggin@gmail.com, diana.craciun@nxp.com, linuxppc-dev@ozlabs.org,
 stable@vger.kernel.org, msuchanek@suse.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Greg KH <gregkh@linuxfoundation.org> writes:

> On Mon, Apr 22, 2019 at 12:19:45AM +1000, Michael Ellerman wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>> 
>> Hi Greg/Sasha,
>> 
>> Please queue up these powerpc patches for 4.4 if you have no objections.
>
> why?  Do you, or someone else, really care about spectre issues in 4.4?
> Who is using ppc for 4.4 becides a specific enterprise distro (and they
> don't seem to be pulling in my stable updates anyway...)?

Someone asked for it, but TBH I can't remember who it was. I can chase
it up if you like.

cheers
