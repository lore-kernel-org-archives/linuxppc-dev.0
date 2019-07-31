Return-Path: <SRS0=JiTK=V4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FEEC32751
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Jul 2019 13:33:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C93C3206A2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Jul 2019 13:33:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C93C3206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45zDrc2yLLzDqjv
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Jul 2019 23:33:04 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45zBjQ5KyVzDqZG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2019 21:56:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 45zBjQ0hd0z9sMQ; Wed, 31 Jul 2019 21:56:42 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 45zBjP5xMjz9s00;
 Wed, 31 Jul 2019 21:56:41 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 107/107] perf vendor events power9: Added missing event
 descriptions
In-Reply-To: <20190730025610.22603-108-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
 <20190730025610.22603-108-acme@kernel.org>
Date: Wed, 31 Jul 2019 21:56:40 +1000
Message-ID: <87a7cuqux3.fsf@concordia.ellerman.id.au>
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
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
 Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Michael Petlan <mpetlan@redhat.com>,
 Paul Clarke <pc@us.ibm.com>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, Carl Love <cel@us.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Arnaldo Carvalho de Melo <acme@kernel.org> writes:
> From: Michael Petlan <mpetlan@redhat.com>
>
> Documentation source:
>
> https://wiki.raptorcs.com/w/images/6/6b/POWER9_PMU_UG_v12_28NOV2018_pub.pdf
>
> Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> Reviewed-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
> Cc: Carl Love <cel@us.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Cc: Paul Clarke <pc@us.ibm.com>
> Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Cc: linuxppc-dev@ozlabs.org
> LPU-Reference: 20190719100837.7503-1-mpetlan@redhat.com
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
