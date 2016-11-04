Return-Path: <lsanfil@marvell.com>
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t9KJx3FHSzDvXv
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2016 22:25:52 +1100 (AEDT)
Subject: Re: Coding Style: Reverse XMAS tree declarations ? (was Re: [PATCH
 net-next v6 02/10] dpaa_eth: add support for DPAA Ethernet)
To: Joe Perches <joe@perches.com>, David Miller <davem@davemloft.net>,
 <madalin.bucur@nxp.com>, Andrew Morton <akpm@linux-foundation.org>,
 "Jonathan Corbet" <corbet@lwn.net>
References: <1478117854-8952-1-git-send-email-madalin.bucur@nxp.com>
 <1478117854-8952-3-git-send-email-madalin.bucur@nxp.com>
 <20161103.155816.642712588084106823.davem@davemloft.net>
 <1478242438.1924.31.camel@perches.com>
CC: <netdev@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, <oss@buserror.net>,
 <ppc@mindchasers.com>, <pebolle@tiscali.nl>,
 <joakim.tjernlund@transmode.se>
From: Lino Sanfilippo <lsanfil@marvell.com>
Message-ID: <581C6A7D.8030704@marvell.com>
Date: Fri, 4 Nov 2016 12:01:17 +0100
MIME-Version: 1.0
In-Reply-To: <1478242438.1924.31.camel@perches.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On 04.11.2016 07:53, Joe Perches wrote:
>
> CHECK:REVERSE_XMAS_TREE: Prefer ordering declarations longest to shortest
> #446: FILE: drivers/net/ethernet/ethoc.c:446:
> +			int size = bd.stat >> 16;
> +			struct sk_buff *skb;
>

should not this case be valid? Optically the longer line is already before the shorter.
I think that the whole point in using this reverse xmas tree ordering is to have
the code optically tidied up and not to enforce ordering between variable name lengths.


Regards,
Lino
