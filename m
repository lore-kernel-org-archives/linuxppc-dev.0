Return-Path: <w@1wt.eu>
Received: from 1wt.eu (1wt.eu [62.212.114.60])
 by ozlabs.org (Postfix) with ESMTP id CA7A01400B4
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Apr 2014 21:01:35 +1100 (EST)
Date: Thu, 3 Apr 2014 12:01:28 +0200
From: Willy Tarreau <w@1wt.eu>
To: zhuyj <zyjzyj2000@gmail.com>
Subject: Re: on kernel 2.6.34.15,
 vlan and raw packets can not be received with gfar-enet nic
Message-ID: <20140403100128.GE16158@1wt.eu>
References: <53310F4E.4080104@gmail.com> <533D25D4.4000607@gmail.com>
 <20140403092727.GD16158@1wt.eu> <533D30A1.1060509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <533D30A1.1060509@gmail.com>
Cc: "Yang, Zhangle \(Eric\)" <Zhangle.Yang@windriver.com>,
 netdev@vger.kernel.org, richardcochran@gmail.com,
 linuxppc-dev@lists.ozlabs.org, guang.yang@windriver.com,
 linux-kernel@vger.kernel.org, yongjun_wei@trendmicro.com.cn,
 sandeep.kumar@freescale.com, Claudiu Manoil <claudiu.manoil@freescale.com>,
 "Tao, Yue" <Yue.Tao@windriver.com>, joe@perches.com, festevam@gmail.com,
 clarocq@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Zhu,

On Thu, Apr 03, 2014 at 05:57:53PM +0800, zhuyj wrote:
> I reference the following 2 mainline commits. These 2 commits are based 
> on the current kernel 3.x and ethtool.
> If we only backport these 2 commits on kernel 2.6.x, this problem will 
> not be fixed yet.

OK fine, I just wanted that we keep the reference of these equivalent
patches in the commit message so that if later a newer patch changes
anything they did, at least we have some indications that the commit
might also have to be revisited.

I'll merge your patch and put these references there.

Thanks,
Willy
