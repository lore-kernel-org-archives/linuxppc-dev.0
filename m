Return-Path: <htejun@gmail.com>
Received: from mail-qa0-x231.google.com (mail-qa0-x231.google.com
 [IPv6:2607:f8b0:400d:c00::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6643A1A110D
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Feb 2015 02:44:02 +1100 (AEDT)
Received: by mail-qa0-f49.google.com with SMTP id v8so23824160qal.8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Jan 2015 07:43:59 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Sat, 31 Jan 2015 10:43:57 -0500
From: Tejun Heo <tj@kernel.org>
To: Kevin Hao <haokexin@gmail.com>
Subject: Re: [PATCH 02/15] sata_svw: remove the dependency on PPC_OF
Message-ID: <20150131154357.GA3088@htj.dyndns.org>
References: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
 <1422712065-9403-3-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1422712065-9403-3-git-send-email-haokexin@gmail.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jan 31, 2015 at 09:47:32PM +0800, Kevin Hao wrote:
> The OF functionality has moved to a common place and be used by many
> archs. So we don't need to include the ppc arch specific header files
> and depend on PPC_OF option any more. This is a preparation for
> killing PPC_OF.
> 
> Signed-off-by: Kevin Hao <haokexin@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

Please route as you see fit.

Thanks.

-- 
tejun
