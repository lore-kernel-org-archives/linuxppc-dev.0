Return-Path: <SRS0=4CH2=BF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60BDC433DF
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Jul 2020 17:57:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11B272065F
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Jul 2020 17:57:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11B272065F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BF9dK5QYzzDrZD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2020 03:57:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=perches.com
 (client-ip=216.40.44.222; helo=smtprelay.hostedemail.com;
 envelope-from=joe@perches.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=perches.com
X-Greylist: delayed 403 seconds by postgrey-1.36 at bilbo;
 Mon, 27 Jul 2020 03:55:54 AEST
Received: from smtprelay.hostedemail.com (smtprelay0222.hostedemail.com
 [216.40.44.222])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BF9bG2pnzzDrYf
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2020 03:55:52 +1000 (AEST)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave02.hostedemail.com (Postfix) with ESMTP id 9866518000849
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jul 2020 17:49:14 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay01.hostedemail.com (Postfix) with ESMTP id E72A7100E7B40;
 Sun, 26 Jul 2020 17:49:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: woman01_070b5d426f5a
X-Filterd-Recvd-Size: 1771
Received: from XPS-9350.home (unknown [47.151.133.149])
 (Authenticated sender: joe@perches.com)
 by omf17.hostedemail.com (Postfix) with ESMTPA;
 Sun, 26 Jul 2020 17:49:04 +0000 (UTC)
Message-ID: <add7c13b1ca24c8cb6f243b99d61c19287020efd.camel@perches.com>
Subject: Re: [PATCH 0/9] powerpc: delete duplicated words
From: Joe Perches <joe@perches.com>
To: Randy Dunlap <rdunlap@infradead.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>
Date: Sun, 26 Jul 2020 10:49:03 -0700
In-Reply-To: <b796e912-e945-3cb1-03f8-0f38009634a4@infradead.org>
References: <20200726162902.Horde.TCqHYaODbkzEpM-rFzDd8A2@messagerie.si.c-s.fr>
 <b796e912-e945-3cb1-03f8-0f38009634a4@infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
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
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, 2020-07-26 at 10:23 -0700, Randy Dunlap wrote:
> On 7/26/20 7:29 AM, Christophe Leroy wrote:
> > Randy Dunlap <rdunlap@infradead.org> a écrit :
> > 
> > > Drop duplicated words in arch/powerpc/ header files.
> > 
> > How did you detect them ? Do you have some script for tgat, or you just read all comments ?
> 
> Yes, it's a script that finds lots of false positives, so I have to check
> each and every one of them for validity.

And it's a lot of work too. (thanks Randy)

It could be something like:

$ grep-2.5.4 -nrP --include=*.[ch] '\b([A-Z]?[a-z]{2,}\b)[ \t]*(?:\n[ \t]*\*[ \t]*|)\1\b' * | \
  grep -vP '\b(?:struct|enum|union)\s+([A-Z]?[a-z]{2,})\s+\*?\s*\1\b' | \
  grep -vP '\blong\s+long\b' | \
  grep -vP '\b([A-Z]?[a-z]{2,})(?:\t+| {2,})\1\b'


