Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D9FAC433EF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Jan 2022 10:35:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JYkTw36K3z30QX
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Jan 2022 21:35:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=omp.ru
 (client-ip=45.84.86.114; helo=mxout04.lancloud.ru;
 envelope-from=s.shtylyov@omp.ru; receiver=<UNKNOWN>)
X-Greylist: delayed 458 seconds by postgrey-1.36 at boromir;
 Wed, 12 Jan 2022 21:04:21 AEDT
Received: from mxout04.lancloud.ru (mxout04.lancloud.ru [45.84.86.114])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JYjpG007Fz2xsJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jan 2022 21:04:21 +1100 (AEDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 8F26A20C5FE3
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: consolidate the compat fcntl definitions
To: Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>
References: <20220111083515.502308-1-hch@lst.de>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <4ae57b3d-0758-1a05-b743-c46a97d09e5e@omp.ru>
Date: Wed, 12 Jan 2022 12:56:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220111083515.502308-1-hch@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
X-Mailman-Approved-At: Wed, 12 Jan 2022 21:34:52 +1100
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
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-parisc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, Guo Ren <guoren@kernel.org>,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello!

On 1/11/22 11:35 AM, Christoph Hellwig wrote:

> currenty the compat fcnt definitions are duplicate for all compat

   fcntl?

> architectures, and the native fcntl64 definitions aren't even usable
> from userspace due to a bogus CONFIG_64BIT ifdef.  This series tries
> to sort out all that.

[...]

MBR, Sergey
