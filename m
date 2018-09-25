Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42K2HY69qHzDqD5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 10:38:33 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>, ego@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/pseries: Disable CPU hotplug across migrations
In-Reply-To: <89531902-477b-660a-227c-8563e4ca076a@linux.vnet.ibm.com>
References: <153721164232.32706.4283915467151746975.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
 <CAHZ_5WxcDxV5vrdW5Y1QaucXLL8Z4xskEbm+y4VFeNsj-38e7g@mail.gmail.com>
 <d0a4995c-949b-f6a4-889a-908e6f72036e@linux.vnet.ibm.com>
 <87va6v5qhx.fsf@concordia.ellerman.id.au> <20180924085606.GA16671@in.ibm.com>
 <b61828ef-b07f-93b1-6185-d4d62bd8fd77@linux.vnet.ibm.com>
 <89531902-477b-660a-227c-8563e4ca076a@linux.vnet.ibm.com>
Date: Tue, 25 Sep 2018 10:38:33 +1000
Message-ID: <87k1na5s3a.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Tyrel Datwyler <tyreld@linux.vnet.ibm.com> writes:
> On 09/24/2018 07:30 AM, Nathan Fontenot wrote:
...
>> 
>> Since we have not been able to re-create the failure with this patch would
>> it be ok to pull in this patch while other options are explored?
>
> I think mpe initially applied this to -next. Not sure if he dropped
> it, but I would definitely give a +1 to carrying this workaround for
> now until we can put together an API that fully closes the gap. We are
> hot with LPM blocked tests at the moment.

Yeah it's in next, I'm not going to drop it. Any fix would be an
incremental fix on top.

cheers
