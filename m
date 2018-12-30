Return-Path: <SRS0=B87Y=PH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E3BC43387
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Dec 2018 21:46:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 742382070D
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Dec 2018 21:46:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 742382070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43SYsv6pckzDqJ5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Dec 2018 08:46:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=telegraphics.com.au
 (client-ip=98.124.60.144; helo=kvm5.telegraphics.com.au;
 envelope-from=fthain@telegraphics.com.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=telegraphics.com.au
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 43SYqd1Cc4zDqHK
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Dec 2018 08:44:12 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by kvm5.telegraphics.com.au (Postfix) with ESMTP id B1B9D29951;
 Sun, 30 Dec 2018 16:44:09 -0500 (EST)
Date: Mon, 31 Dec 2018 08:44:07 +1100 (AEDT)
From: Finn Thain <fthain@telegraphics.com.au>
To: James Bottomley <jejb@linux.vnet.ibm.com>
Subject: Re: [PATCH v8 01/25] scsi/atari_scsi: Don't select CONFIG_NVRAM
In-Reply-To: <1546193203.2844.9.camel@linux.vnet.ibm.com>
Message-ID: <alpine.LNX.2.21.1812310839050.444@nippy.intranet>
References: <cover.1545784679.git.fthain@telegraphics.com.au>
 <e68fcc3ec0a6cd4e14f763366d4d9445890b9b82.1545784679.git.fthain@telegraphics.com.au>
 <20181228173846.Horde.z_zDEJN0rVd8tkt3HjYzmg2@messagerie.si.c-s.fr> 
 <alpine.LNX.2.21.1812291050330.152@nippy.intranet>
 <a170720a-fe17-744d-790b-e258465bd75e@gmail.com>
 <alpine.LNX.2.21.1812291327380.152@nippy.intranet>
 <5e901432-65e2-c87b-31e3-36a394687a9a@gmail.com> 
 <CAK8P3a1J3sy55nd5QbxR5AjxkLyE-RE=bDNKB9sG27xx=mZ60A@mail.gmail.com>
 <20181230185002.Horde.AdSknvcs4hP1Kh_T_Cos6w8@messagerie.si.c-s.fr>
 <1546193203.2844.9.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Michael Schmitz <schmitzmic@gmail.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 linux-scsi <linux-scsi@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, 30 Dec 2018, James Bottomley wrote:

> 
> That said, as has been pointed out, the current #ifdef has a failing 
> corner case when both are modular (because the code should then be 
> included).  The runtime macro that correctly expresses this is 
> IS_REACHABLE(CONFIG_NVRAM).
> 

No, in the case of CONFIG_NVRAM=m, the conditional code is deliberately 
excluded. This is discussed in the patch description. The convention on 
PPC32 is that device drivers drop support for NVRAM in this situation. 

I've adopted the PPC32 convention here because M68K drivers and PPC32 
drivers have to co-exist (I'm thinking of valkyriefb, but there are other 
examples).

-- 

> James
> 
> 
