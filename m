Return-Path: <SRS0=YLyy=SL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CE5C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 16:07:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 731FB2084C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 16:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 731FB2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44dsd24t3vzDqM4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 02:07:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=fweimer@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44dsZ24bsVzDqKK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 02:04:58 +1000 (AEST)
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3F052C0AF7B2;
 Tue,  9 Apr 2019 16:04:56 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-116-95.ams2.redhat.com
 [10.36.116.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 042D217AD3;
 Tue,  9 Apr 2019 16:04:54 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: hpa@zytor.com
Subject: Re: [PATCH] Linux: Define struct termios2 in <termios.h> under
 _GNU_SOURCE [BZ #10339]
References: <875zrnlakd.fsf@oldenburg2.str.redhat.com>
 <CA8DB086-0ABB-4E37-93F3-89A64B8012DF@zytor.com>
Date: Tue, 09 Apr 2019 18:04:53 +0200
In-Reply-To: <CA8DB086-0ABB-4E37-93F3-89A64B8012DF@zytor.com> (hpa's message
 of "Tue, 09 Apr 2019 09:07:11 -0600")
Message-ID: <87y34ji2qi.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Tue, 09 Apr 2019 16:04:56 +0000 (UTC)
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
Cc: linux-api@vger.kernel.org, libc-alpha@sourceware.org,
 linuxppc-dev@lists.ozlabs.org, adhemerval.zanella@linaro.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

* hpa:

> Anything blocking the POC code I provided?

I don't recall that, sorry.  Would you please provide a reference?

Thanks,
Florian
