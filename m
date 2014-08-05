Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A124D1A0148
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Aug 2014 17:25:54 +1000 (EST)
Date: Tue, 5 Aug 2014 17:25:55 +1000
From: Anton Blanchard <anton@samba.org>
To: Emil Medve <Emilian.Medve@Freescale.com>
Subject: Re: [PATCH 1/2 v3] bootmem/powerpc: Unify bootmem initialization
Message-ID: <20140805172555.001ac170@kryten>
In-Reply-To: <1399532799-1557-1-git-send-email-Emilian.Medve@Freescale.com>
References: <1399532799-1557-1-git-send-email-Emilian.Medve@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Emil,

> Unify the low/highmem code path from do_init_bootmem() by using (the)
> lowmem related variables/parameters even when the low/highmem split
> is not needed (64-bit) or configured. In such cases the "lowmem"
> variables/parameters continue to observe the definition by referring
> to memory directly mapped by the kernel

Ben pointed me at this patch after I had finished my bootmem removal
series. I can rebase on this one if it makes sense.

Anton
