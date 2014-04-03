Return-Path: <w@1wt.eu>
Received: from 1wt.eu (1wt.eu [62.212.114.60])
 by ozlabs.org (Postfix) with ESMTP id 13BEF14009D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Apr 2014 21:21:42 +1100 (EST)
Date: Thu, 3 Apr 2014 12:21:36 +0200
From: Willy Tarreau <w@1wt.eu>
To: zhuyj <zyjzyj2000@gmail.com>
Subject: Re: on kernel 2.6.34.15,
 vlan and raw packets can not be received with gfar-enet nic
Message-ID: <20140403102136.GF16158@1wt.eu>
References: <53310F4E.4080104@gmail.com> <533D25D4.4000607@gmail.com>
 <20140403092727.GD16158@1wt.eu> <533D34BD.900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <533D34BD.900@gmail.com>
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

On Thu, Apr 03, 2014 at 06:15:25PM +0800, zhuyj wrote:
> Hi, Willy
> 
> I made a new patch. In long commit message, I inserted the equivalent 
> mainline commit
> about this feature. Maybe it is better. Now this patch is in the 
> attachment. Please check
> and merge it into kernel 2.6.32.62.

Sure, it's much better this way.

Thanks!
Willy
