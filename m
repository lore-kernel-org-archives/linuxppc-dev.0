Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0140.outbound.protection.outlook.com [207.46.163.140])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B3EB01A0186
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Aug 2014 17:37:45 +1000 (EST)
Message-ID: <53E087AD.1070605@Freescale.com>
Date: Tue, 5 Aug 2014 02:28:45 -0500
From: Emil Medve <Emilian.Medve@Freescale.com>
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 1/2 v3] bootmem/powerpc: Unify bootmem initialization
References: <1399532799-1557-1-git-send-email-Emilian.Medve@Freescale.com>
 <20140805172555.001ac170@kryten>
In-Reply-To: <20140805172555.001ac170@kryten>
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Anton,


On 08/05/2014 02:25 AM, Anton Blanchard wrote:
> Hi Emil,
> 
>> Unify the low/highmem code path from do_init_bootmem() by using (the)
>> lowmem related variables/parameters even when the low/highmem split
>> is not needed (64-bit) or configured. In such cases the "lowmem"
>> variables/parameters continue to observe the definition by referring
>> to memory directly mapped by the kernel
> 
> Ben pointed me at this patch after I had finished my bootmem removal
> series. I can rebase on this one if it makes sense.

I'll deffer to your judgment. I'm just happy to see bootmem gone

Later today, I'll test your patch series on some boards I have and I'll
notify you of the result. I have some of_reserved_mem based code that I
think will be a nice test case


Cheers,
