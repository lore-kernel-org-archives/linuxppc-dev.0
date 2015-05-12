Return-Path: <benh@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49AB21A0007
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 06:40:52 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Wed, 13 May 2015 06:40:51 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id C17C83578048
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 06:40:45 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4CKebpu31064174
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 06:40:45 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4CKeDcH012425
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 06:40:13 +1000
Message-ID: <1431463180.20218.57.camel@au1.ibm.com>
Subject: Re: G5 Xserve rackmeter broken?
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Wed, 13 May 2015 06:39:40 +1000
In-Reply-To: <20150512175555.GB609@fuloong-minipc.musicnaut.iki.fi>
References: <20150510183259.GA13777@aspire-one.musicnaut.iki.fi>
 <1431296015.13039.12.camel@kernel.crashing.org>
 <20150512175555.GB609@fuloong-minipc.musicnaut.iki.fi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-05-12 at 20:55 +0300, Aaro Koskinen wrote:
> I'm running with HZ=100 so the values are still probably within
> jiffy resolution, so perhaps the calculation should first do
> idle = min(idle, total)?

Does it gives you a reasonable output if you do that ?

Cheers,
Ben.
