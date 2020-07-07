Return-Path: <SRS0=AwiL=AS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F3AC433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2020 14:07:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D85CA206E2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2020 14:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D85CA206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sguazz.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B1PQD4FZRzDqjx
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2020 00:07:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=centrum.lixper.it (client-ip=46.4.16.148; helo=centrum.lixper.it;
 envelope-from=srs0=ts6c=as=sguazz.it=giuseppe@centrum.lixper.it;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=sguazz.it
Received: from centrum.lixper.it (centrum.lixper.it [46.4.16.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B1PLH57r1zDqq3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2020 00:03:50 +1000 (AEST)
Received: from net-130-25-222-52.cust.vodafonedsl.it ([130.25.222.52]
 helo=uefi)
 by centrum.lixper.it with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.84_2) (envelope-from <giuseppe@sguazz.it>)
 id 1jsoCD-0003Aw-4g
 for linuxppc-dev@lists.ozlabs.org; Tue, 07 Jul 2020 16:03:47 +0200
Message-ID: <c98f8586c16c86bb9b4485138bbabce9f15c282b.camel@sguazz.it>
Subject: Re: kernel since 5.6 do not boot anymore on Apple PowerBook
From: Giuseppe Sacco <giuseppe@sguazz.it>
To: linuxppc-dev@lists.ozlabs.org
Date: Tue, 07 Jul 2020 16:03:35 +0200
In-Reply-To: <04544f16-fb20-54b9-e56e-47d45af03b6c@csgroup.eu>
References: <89e412a76350b28f791bb8a2b6f9647a034f6fc8.camel@sguazz.it>
 <04544f16-fb20-54b9-e56e-47d45af03b6c@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GeoIP: IT
X-SRS: Sender address rewritten from <giuseppe@sguazz.it> to
 <SRS0=Ts6C=AS=sguazz.it=giuseppe@centrum.lixper.it> by centrum.lixper.it.
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello Cristophe,

Il giorno mar, 07/07/2020 alle 15.35 +0200, Christophe Leroy ha
scritto:
> Hi,
> Le 07/07/2020 à 14:58, Giuseppe Sacco a écrit :
[...]
> > So, I am looking for help. How may I better investigate the
> > problem?
> > How may I crossbuild the kernel on a faster machine (amd64) in
> > order to
> > try git-bisect without waiting ages?
> 
> To crossbuild, use cross tools at 
> https://mirrors.edge.kernel.org/pub/tools/crosstool/

thank you, I'll have a look at it.

> Can you tell which defconfig you use or provide your .config

You may get the standard one from debian or a reduced one that I made
on purpose. The latter is here:
https://eppesuigoccas.homedns.org/~giuseppe/config-5.4.50.gz (boot)
https://eppesuigoccas.homedns.org/~giuseppe/config-5.6.19.gz (no boot)

Bye,
Giuseppe

