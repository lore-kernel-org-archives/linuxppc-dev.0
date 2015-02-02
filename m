Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B521D1A0C41
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Feb 2015 13:25:38 +1100 (AEDT)
Message-ID: <1422843937.11325.3.camel@ellerman.id.au>
Subject: Re: [PATCH 00/15] powerpc: kill PPC_OF
From: Michael Ellerman <mpe@ellerman.id.au>
To: Kevin Hao <haokexin@gmail.com>
Date: Mon, 02 Feb 2015 13:25:37 +1100
In-Reply-To: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
References: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
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

On Sat, 2015-01-31 at 21:47 +0800, Kevin Hao wrote:
> Hi,
> 
> This patch series tries to kill the PPC_OF.

So on the whole this series looks good.

Getting it merged is going to be a bit of a pain though. I assume most of them
depend on patch 1, in which case they really need to go in as one series.

So you'll just have to collect acks from all the driver/subsystem maintainers,
and then we can take it all through the powerpc tree.

cheers
