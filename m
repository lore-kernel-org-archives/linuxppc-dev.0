Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 695D2C6FD1F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2024 14:03:12 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; secure) header.d=wetzel-home.de header.i=@wetzel-home.de header.a=rsa-sha256 header.s=wetzel-home header.b=uwHSo1tf;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V88jW096Vz3vYP
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2024 01:03:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; secure) header.d=wetzel-home.de header.i=@wetzel-home.de header.a=rsa-sha256 header.s=wetzel-home header.b=uwHSo1tf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wetzel-home.de (client-ip=2a03:4000:40:5b2::1; helo=ns2.wdyn.eu; envelope-from=alexander@wetzel-home.de; receiver=lists.ozlabs.org)
Received: from ns2.wdyn.eu (ns2.wdyn.eu [IPv6:2a03:4000:40:5b2::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V88hd6g20z3cCx
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2024 01:02:22 +1100 (AEDT)
Message-ID: <c5354ac2-5714-42ce-bf2f-9d022ddd2945@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1712066534;
	bh=+KeKKu8j5PtDlcTYULHI2jYuASxxmJesbzSHT/V5rDI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=uwHSo1tfz2wKMcCsEBf9bEAqr84kDSQ4hG6VxetzuNCQxCaRlZgUmTLH7lEiU8nPw
	 8rZ4gXr2y21VmkbxeAFdUbauLTt8MHFwqAqGVmpY9klkR8Sz3drGHT6Xzg9i9k0yag
	 5aDtHYeWQJY3rWD7enRekLfJNaBAyrbWWDLkBIA4=
Date: Tue, 2 Apr 2024 16:02:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Revert commit 27f58c04a8f438078583041468ec60597841284d]
 [linux-next] [6.9.0-rc1-next-20240328] WARNING: CPU: 9 PID: 209 at
 drivers/scsi/sg.c:2236 sg_remove_sfp_usercontext+0x270/0x280 [sg]
To: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>, bvanassche@acm.org,
 martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <62efbf21-fdb5-4c3b-a370-085b39672b72@linux.vnet.ibm.com>
Content-Language: en-US, de-DE
From: Alexander Wetzel <alexander@wetzel-home.de>
In-Reply-To: <62efbf21-fdb5-4c3b-a370-085b39672b72@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: sachinp@linux.vnet.com, sfr@canb.auug.org.au, mputtash@linux.vnet.com, abdhalee@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 02.04.24 15:51, Venkat Rao Bagalkote wrote:
> Greetings!!
> 
> 
> Below warnings is observed with the commit 
> 27f58c04a8f438078583041468ec60597841284d.
> 
> 
> Once reverting the above commit id, issue is resloved.
> 
> 
> Please help in fixing this issue.

The fix for that is currently in review:
https://lore.kernel.org/all/20240401191038.18359-1-Alexander@wetzel-home.de/

Sorry for that,

Alexander
