Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 by lists.ozlabs.org (Postfix) with ESMTP id 3rvrB757rzzDqZ7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jul 2016 07:47:59 +1000 (AEST)
Date: Wed, 20 Jul 2016 14:47:56 -0700 (PDT)
Message-Id: <20160720.144756.1830055477288190098.davem@davemloft.net>
To: weiyj_lk@163.com
Cc: qiang.zhao@nxp.com, yongjun_wei@trendmicro.com.cn,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH -next] wan/fsl_ucc_hdlc: use module_platform_driver to
 simplify the code
From: David Miller <davem@davemloft.net>
In-Reply-To: <1468927516-32569-1-git-send-email-weiyj_lk@163.com>
References: <1468927516-32569-1-git-send-email-weiyj_lk@163.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wei Yongjun <weiyj_lk@163.com>
Date: Tue, 19 Jul 2016 11:25:16 +0000

> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> module_platform_driver() makes the code simpler by eliminating
> boilerplate code.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Applied.
