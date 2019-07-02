Return-Path: <SRS0=fll7=U7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BECC5B578
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jul 2019 02:22:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2166216C8
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jul 2019 02:22:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2166216C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45d7Kh6LWSzDqVB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jul 2019 12:22:00 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45d7J00PCTzDqR6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jul 2019 12:20:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 45d7Hz5m40z9s3Z;
 Tue,  2 Jul 2019 12:20:31 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: Can I compile Linux Kernel 5.2-rc7 for PowerPC on Intel/AMD x86
 hardware?
In-Reply-To: <da969d6f-d5cb-88d7-77b5-54d804a067d7@c-s.fr>
References: <SG2PR01MB2141EE2AEA0C727527DAC4B087F90@SG2PR01MB2141.apcprd01.prod.exchangelabs.com>
 <da969d6f-d5cb-88d7-77b5-54d804a067d7@c-s.fr>
Date: Tue, 02 Jul 2019 12:20:31 +1000
Message-ID: <87sgrpi3dc.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> Le 01/07/2019 =C3=A0 15:39, Turritopsis Dohrnii Teo En Ming a =C3=A9crit=
=C2=A0:
>> Good evening from Singapore,
>
> Good evening afternoon from Paris,
>
>>=20
>> Can I compile Linux Kernel 5.2-rc7 for PowerPC on Intel/AMD x86 hardware=
, for example, AMD Ryzen 9 3950X, with 16 CPU cores and 32 threads?
>
> Yes you can
>
>>=20
>> Is it called cross-compiling?
>
> Yes it is, you can get cross compilers at=20
> https://mirrors.edge.kernel.org/pub/tools/crosstool/

There's also some info here:

  https://github.com/linuxppc/wiki/wiki/Building-powerpc-kernels


cheers
