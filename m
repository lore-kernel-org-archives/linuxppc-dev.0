Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-la0-f50.google.com (mail-la0-f50.google.com
 [209.85.215.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7C32D1A03ED
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2015 12:33:11 +1000 (AEST)
Received: by labbc20 with SMTP id bc20so12678266lab.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Jun 2015 19:33:07 -0700 (PDT)
Message-ID: <557E39DE.4070802@linux.com>
Date: Mon, 15 Jun 2015 05:35:10 +0300
From: Alexander Popov <alex.popov@linux.com>
Reply-To: alex.popov@linux.com
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
CC: pantelis.antoniou@gmail.com, vbordug@ru.mvista.com,
 christophe.leroy@c-s.fr, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] net: fs_enet: Disable NETIF_F_SG feature for Freescale
 MPC5121
References: <1433894262-28900-1-git-send-email-alex.popov@linux.com>
 <20150609.171441.861174213383180358.davem@davemloft.net>
In-Reply-To: <20150609.171441.861174213383180358.davem@davemloft.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

10.06.2015 03:14, David Miller пишет:
> From: Alexander Popov <alex.popov@linux.com>
> Date: Wed, 10 Jun 2015 02:57:42 +0300
>
>> skb_copy_from_linear_data() which doesn't work well for non-linear sk_buff:
>
> The correct fix is to use an SKB copy routine which can
> handle non-linear data.

Thanks, David.
I'll prepare the second version of the patch.

Best regards,
Alexander
