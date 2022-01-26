Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4FA6C28CF5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Jan 2022 12:13:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JkN0h2VCSz3bbG
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Jan 2022 23:13:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=molgen.mpg.de (client-ip=141.14.17.11; helo=mx1.molgen.mpg.de;
 envelope-from=pmenzel@molgen.mpg.de; receiver=<UNKNOWN>)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JkN0D619rz2yQ9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jan 2022 23:12:58 +1100 (AEDT)
Received: from [192.168.0.2] (ip5f5aecd1.dynamic.kabel-deutschland.de
 [95.90.236.209])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id D6B2F61EA191D;
 Wed, 26 Jan 2022 13:12:55 +0100 (CET)
Message-ID: <e2e25fc9-ff40-9183-6ca7-fab4708fa1d0@molgen.mpg.de>
Date: Wed, 26 Jan 2022 13:12:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 1/3] lib/raid6/test/Makefile: Use `$(pound)` instead of
 `\#` for Make 4.3
Content-Language: en-US
To: David Laight <David.Laight@ACULAB.COM>
References: <20220126114144.370517-1-pmenzel@molgen.mpg.de>
 <0214ae2639174812948a631ac4e142c8@AcuMS.aculab.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <0214ae2639174812948a631ac4e142c8@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: linux-raid@vger.kernel.org, Song Liu <song@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, Matt Brown <matthew.brown.dev@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Dear David,


Am 26.01.22 um 13:06 schrieb David Laight:
> From: Paul Menzel
>> Sent: 26 January 2022 11:42
> ..
>> +pound := \#
> 
> Please use 'hash' not 'pound'.
> Only american greengrocers use that horrid name.
> 
> A 'pound' is '£'.

Sure, I can change that, if you send a patch cleaning this up for the 
other files already using that in the tree? ;-) Or can it be different 
all over the Linux code base?


Kind regards,

Paul


PS:

> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)

If you care, the standard signature delimiter is `-- ` [1].


[1]: https://en.wikipedia.org/wiki/Signature_block#Standard_delimiter
